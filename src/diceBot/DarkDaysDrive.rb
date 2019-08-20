# -*- coding: utf-8 -*-

class DarkDaysDrive < DiceBot
  def initialize
    super
    @d66Type = 2
  end

  def gameName
    'ダークデイズドライブ'
  end

  def gameType
    "DarkDaysDrive"
  end

  def getHelpMessage
    return <<INFO_MESSAGE_TEXT
・判定
スペシャル／ファンブル／成功／失敗を判定
・各種表
RTT	ランダム特技決定表
ABRT アビリティ決定表
DT ダメージ表
FT 失敗表
GJT 大成功表
ITT 移動トラブル表
NTT 任務トラブル表
STT 襲撃トラブル表
HTT 変身トラブル表
DET ドライブイベント表
BET ブレイクイベント表
CT キャンプ表
KZT 関係属性表
IA イケメンアクション決定表
 IAA 遠距離
 IAB 移動
 IAC 近距離
 IAD 善人
 IAE 悪人
 IAF 幼い
 IAG バカ
 IAH 渋い
 IAI 賢い
 IAJ 超自然
・D66ダイスあり
INFO_MESSAGE_TEXT
  end

  # ゲーム別成功度判定(2D6)
  def check_2D6(total_n, dice_n, signOfInequality, diff, _dice_cnt, _dice_max, _n1, _n_max)
    return '' unless signOfInequality == ">="

    output =
      if dice_n <= 2
        " ＞ ファンブル(判定失敗。失敗表(FT)を追加で１回振る)"
      elsif dice_n >= 12
        " ＞ スペシャル(判定成功。大成功表(GJT)を１回使用可能)"
      elsif total_n >= diff
        " ＞ 成功"
      else
        " ＞ 失敗"
      end

    return output
  end

  def rollDiceCommand(command)
    string = command.upcase

    case string
    when 'RTT' # ランダム特技決定表
      return getRandomSkillTableResult(command)
    end

    return getTableDiceCommandResult(command)
  end

  # 指定特技ランダム決定表
  def getRandomSkillTableResult(_command)
    name = 'ランダム'

    skillTableFull = [
      ['背景', ['呪い', '絶望', '孤児', '死別', '一般人', '獲物', '憧れ', '友人', '挑戦者', '血縁', '永遠']],
      ['仕事',  ['脅迫', '捨てる', '拉致', '盗む', 'ハッキング', '侵入', '変装', 'だます', '隠す', 'のぞく', '聞き出す']],
      ['捜索',  ['トイレ', '食事', '自然', '運動施設', '街', '友愛会', '暗部', '史跡', '文化施設', '温泉', '宿泊']],
      ['趣味',  ['お酒', 'グルメ', 'ダンス', 'スポーツ', '健康', 'ファッション', '恋愛', 'フェス', '音楽', '物語', '学問']],
      ['雰囲気',  ['だらしない', 'のんびり', '暖かい', '明るい', '甘い', '普通', '洗練', '渋い', '静か', '真面目', '冷たい']],
      ['戦闘法',  ['忍術', '古武術', '剣術', '棒術', '拳法', 'ケンカ', '総合格闘技', 'レスリング', '軍隊格闘術', '射撃', '弓術']],
    ]

    skillTable, total_n = get_table_by_1d6(skillTableFull)
    tableName, skillTable = skillTable
    skill, total_n2 = get_table_by_2d6(skillTable)

    output = "#{name}指定特技表(#{total_n},#{total_n2}) ＞ 『#{tableName}』#{skill}"

    return output
  end

  def getTableDiceCommandResult(command)
    info = @@tables[command]
    return nil if info.nil?

    name = info[:name]
    type = info[:type]
    table = info[:table]

    text, number =
      case type
      when '2D6'
        get_table_by_2d6(table)
      when '1D6'
        get_table_by_1d6(table)
      when 'D66S'
        table = getD66Table(table)
        get_table_by_d66_swap(table)
      when 'D66N'
        table = getD66Table(table)
        isSwap = false
        number = bcdice.getD66(isSwap)
        result = get_table_by_number(number, table)
        [result, number]
      end

    return nil if text.nil?

    return "#{name}(#{number}) ＞ #{text}"
  end

  def getD66Table(table)
    table.map do |item|
      if item.is_a?(String) && (/^(\d+):(.*)/ === item)
        [$1.to_i, $2]
      else
        item
      end
    end
  end

  @@tables =
    {
      'ABRT' => {
        :name => "アビリティ決定表",
        :type => 'D66S',
        :table => %w{
          11:インストラクター(P155)
          12:運送業(P155)
          13:運転手(P155)
          14:カフェ店員(P155)
          15:趣味人(P155)
          16:ショップ店員(P155)
          22:正社員(P156)
          23:大工(P156)
          24:探偵(P156)
          25:バイヤー(P156)
          26:俳優(P156)
          33:派遣社員(P156)
          34:犯罪者(P157)
          35:バンドマン(P157)
          36:バーテンダー(P157)
          44:ヒモ(P157)
          45:ホスト(P157)
          46:ホテルマン(P157)
          55:無職(P158)
          56:用心棒(P158)
          66:料理人(P158)
        },
      },

      'DT' => {
        :name => "ダメージ表",
        :type => '1D6',
        :table => %w{
          疲れ
          痛み
          焦り
          不調
          ショック
          ケガ
        },
      },

      'FT' => {
        :name => "失敗表",
        :type => '1D6',
        :table => %w{
          任意のアイテムを一つ失う
          １ダメージを受ける
          【所持金ランク】が１減少する（最低０）
          ２ダメージを受ける
          【所持金ランク】が２減少する（最低０）
          標的レベルが１増加する
        },
      },

      'GJT' => {
        :name => "大成功表",
        :type => '1D6',
        :table => %w{
          主人からお褒めの言葉をいただく
          ダメージを１回復する
          ダメージを１回復する
          関係のチェックを一つ消す
          ダメージを２回復する
          【所持金ランク】が１増加する
        },
      },

      'ITT' => {
        :name => "移動トラブル表",
        :type => '1D6',
        :table => %w{
          検問（P220)
          急な腹痛（P220)
          黒煙（P221)
          蚊（P221)
          落とし物（P222)
          空腹（P222)
        },
      },

      'NTT' => {
        :name => "任務トラブル表",
        :type => '1D6',
        :table => %w{
          通報（P223)
          プレッシャー（P223)
          マナー違反（P224)
          志願者（P224)
          仲間割れ（P225)
          狩人の噂（P225)
        },
      },

      'STT' => {
        :name => "襲撃トラブル表",
        :type => '1D6',
        :table => %w{
          孤独な追跡者（P226)
          地元の若者たち（P226)
          V-FILES（P227)
          チンピラの群れ（P227)
          孤独な狩人（P228)
          狩人の群れ（P228)
        },
      },

      'HTT' => {
        :name => "変身トラブル表",
        :type => 'D66N',
        :table => %w{
          11:あれを食べたい(P214)
          12:あれを着たい(P214)
          13:あれを見たい(P215)
          14:あれを狩りたい(P215)
          15:あれを踊りたい(P216)
          16:あれに入りたい(P216)
          21:強奪(P217)
          22:暴行(P217)
          23:虐殺(P218)
          24:誘拐(P218)
          25:無精(P219)
          26:失踪(P219)
          31:あれを食べたい(P214)
          32:あれを着たい(P214)
          33:あれを見たい(P215)
          34:あれを狩りたい(P215)
          35:あれを踊りたい(P216)
          36:あれに入りたい(P216)
          41:強奪(P217)
          42:暴行(P217)
          43:虐殺(P218)
          44:誘拐(P218)
          45:無精(P219)
          46:失踪(P219)
          51:あれを食べたい(P214)
          52:あれを着たい(P214)
          53:あれを見たい(P215)
          54:あれを狩りたい(P215)
          55:あれを踊りたい(P216)
          56:あれに入りたい(P216)
          61:強奪(P217)
          62:暴行(P217)
          63:虐殺(P218)
          64:誘拐(P218)
          65:無精(P219)
          66:失踪(P219)
        },
      },

      'DET' => {
        :name => "ドライブイベント表",
        :type => '1D6',
        :table => %w{
          身の上話をする。目標が背景分野で選択している特技がドライブ判定の指定特技になる。
          スキル自慢をする。目標が仕事分野で選択している特技がドライブ判定の指定特技になる。
          むかし行った場所の話をする。目標が捜索分野で選択している特技がドライブ判定の指定特技になる。
          趣味の話をする。目標が趣味分野で選択している特技がドライブ判定の指定特技になる。
          テーマがない雑談をする。目標が雰囲気分野で選択している特技がドライブ判定の指定特技になる。
          物騒な話をする。目標が戦闘法分野で選択している特技がドライブ判定の指定特技になる。
        },
      },

      'BET' => {
        :name => "ブレイクイベント表",
        :type => '1D6',
        :table => %w{
          イケメンの車は風光明美な場所に到着する。197ページの「観光地」を参照。
          イケメンの車は明るい光に照らされた小さな店に到着する。197ページの「コンビニ」を参照。
          イケメンの車は巨大かつ何でも売っている店に到着する。198ページの「ホームセンター」を参照。
          イケメンの車はドライバーたちの憩いの地に到着する。198ページの「サービスエリア」を参照。
          イケメンの車は大きなサービスエリアのような場所に到着する。199ページの「道の駅」を参照。
          イケメンの車は闇の底に隠された秘密の場所に到着する。199ページの「友愛会支部」を参照。
        },
      },

      'CT' => {
        :name => "キャンプ表",
        :type => '1D6',
        :table => %w{
          無料仮眠所・いい感じの空き地：定員無制限／居住性-2／価格0／発見率2
          カプセルホテル：定員1／居住性-1／価格3／発見率2
          ラブホテル：定員2／居住性0／価格4／発見率1
          ビジネスホテル：定員2／居住性0／価格4／発見率1
          観光ホテル：定員4／居住性1／価格5／発見率1
          高級ホテル：定員4／居住性2／価格6／発見率0
        },
      },

      'KZT' => {
        :name => "関係属性表",
        :type => '1D6',
        :table => %w{
          軽蔑
          反感
          混乱
          興味
          共感
          憧れ
        },
      },

      'IA' => {
        :name => "イケメンアクション決定表",
        :type => 'D66S',
        :table => %w{
          11:遠距離
          12:遠距離
          13:移動
          14:移動
          15:近距離
          16:近距離
          22:善人
          23:善人
          24:悪人
          25:悪人
          26:幼い
          33:幼い
          34:バカ
          35:バカ
          36:渋い
          44:渋い
          45:賢い
          46:賢い
          55:超自然
          56:超自然
          66:振り直しor自由選択
        },
      },

      'IAA' => {
        :name => "イケメンアクション（遠距離）表",
        :type => '1D6',
        :table => %w{
          目を合わせて微笑む（かっこよさ：4）
          場所を譲る（かっこよさ：4）
          髪をかきあげる（かっこよさ：5）
          複雑なポーズで座る（かっこよさ：5）
          物憂げな表情で振り返る（かっこよさ：6）
          ものを上に持つ（かっこよさ：6）
        },
      },

      'IAB' => {
        :name => "イケメンアクション（移動）表",
        :type => '1D6',
        :table => %w{
          車道側を歩く（かっこよさ：4）
          乗り物から降りる（かっこよさ：4）
          真剣な表情で近づく（かっこよさ：4）
          馬に乗る（かっこよさ：6）
          ダメージを受けつつ移動（かっこよさ：6）
          瞬間移動（かっこよさ：6）
        },
      },

      'IAC' => {
        :name => "イケメンアクション（近距離）表",
        :type => '1D6',
        :table => %w{
          黙って見つめる（かっこよさ：3）
          ちょっとしたプレゼント（かっこよさ：3）
          顎クイ（かっこよさ：5）
          壁ドン（かっこよさ：5）
          お姫様抱っこ（かっこよさ：7）
          床ドン（かっこよさ：7）
        },
      },

      'IAD' => {
        :name => "イケメンアクション（善人）表",
        :type => '1D6',
        :table => %w{
          手を引いて逃げる（かっこよさ：4）
          毛布を掛ける（かっこよさ：4）
          守る（かっこよさ：5）
          笑って去る（かっこよさ：5）
          全てを捧げる（かっこよさ：6）
          悪堕ち（かっこよさ：6）
        },
      },

      'IAE' => {
        :name => "イケメンアクション（悪人）表",
        :type => '1D6',
        :table => %w{
          攻撃する（かっこよさ：4）
          暗く笑う（かっこよさ：4）
          奪う（かっこよさ：4）
          目論見を口にする（かっこよさ：6）
          罠にかける（かっこよさ：6）
          改心する（かっこよさ：6）
        },
      },

      'IAF' => {
        :name => "イケメンアクション（幼い）表",
        :type => '1D6',
        :table => %w{
          甘える（かっこよさ：3）
          疲れる（かっこよさ：3）
          無邪気な発言（かっこよさ：5）
          おねだり（かっこよさ：5）
          上目遣い（かっこよさ：7）
          抱きつく（かっこよさ：7）
        },
      },

      'IAG' => {
        :name => "イケメンアクション（バカ）表",
        :type => '1D6',
        :table => %w{
          苦悩する（かっこよさ：4）
          屈託のない笑顔（かっこよさ：4）
          転ぶ（かっこよさ：4）
          叫ぶ（かっこよさ：6）
          間違える（かっこよさ：6）
          怖がる（かっこよさ：6）
        },
      },

      'IAH' => {
        :name => "イケメンアクション（渋い）表",
        :type => '1D6',
        :table => %w{
          説教（かっこよさ：4）
          気づかせる（かっこよさ：4）
          見守る（かっこよさ：5）
          残心（かっこよさ：5）
          称える（かっこよさ：6）
          いい位置を取る（かっこよさ：6）
        },
      },

      'IAI' => {
        :name => "イケメンアクション（賢い）表",
        :type => '1D6',
        :table => %w{
          難しい本を読む（かっこよさ：3）
          アドバイスをする（かっこよさ：3）
          眼鏡を持ち上げる（かっこよさ：5）
          状況を解説する（かっこよさ：5）
          計算できなくなる（かっこよさ：7）
          大丈夫だと言う（かっこよさ：7）
        },
      },

      'IAJ' => {
        :name => "イケメンアクション（超自然）表",
        :type => '1D6',
        :table => %w{
          水に濡れる（かっこよさ：4）
          風を纏う（かっこよさ：4）
          地割れ（かっこよさ：5）
          火を放つ（かっこよさ：5）
          闇を生み出す（かっこよさ：6）
          光る（かっこよさ：6）
        },
      }

    }

  setPrefixes(['RTT'] + @@tables.keys)
end
