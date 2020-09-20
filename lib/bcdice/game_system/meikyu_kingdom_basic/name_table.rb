module BCDice
  module GameSystem
    class MeikyuKingdomBasic
      # エキゾチック名前表(D66)
      # override
      def mk_name_ex_table(num)
        table = [
          [11, "モアイ／スイショウドクロ"],
          [12, "チュパカブラ／ムベンベ"],
          [13, "カンフー／インヤン"],
          [14, "ブシドー／ミヤコ"],
          [15, "チャンピオン／バービー"],
          [16, "ウパニシャッド／ゾルゲ"],
          [22, "デスマーチ／インテル"],
          [23, "ゴッホ／ヴィクトリア"],
          [24, "ゾンビ／オニャンコポン"],
          [25, "ケロッパ／カルメン"],
          [26, "オーバーキル／サシミ"],
          [33, "ブッチャー／デヴィ"],
          [34, "ブロンソン／マドンナ"],
          [35, "ガイギャックス／エロイカ"],
          [36, "好きな星の名前(スピカ,オリオン)"],
          [44, "好きな武器の名前(エペ,フランベルジュ)"],
          [45, "好きな動物の名前(イタチ,パグ)"],
          [46, "好きな鉱物の名前(ルビィ,ヒスイ)"],
          [55, "好きな言葉＋ドラゴン"],
          [56, "好きな単語表で決定する"],
          [66, "プレイヤーと同じ名前"],
        ]
        return get_table_by_number(num, table)
      end

      # 新名前決定表
      def mk_new_name_table
        nick_table = "1"
        name_table = "1"
        # 新名前表
        nick_n = @randomizer.roll_once(6)
        name_n = @randomizer.roll_once(6)
        d1 = @randomizer.roll_d66(D66SortType::ASC)
        d2 = @randomizer.roll_d66(D66SortType::ASC)

        # 二つ名分岐
        if nick_n <= 1
          nick_table = mk_nick_pr_table(d1)
        elsif name_n <= 2
          nick_table = mk_nick_fo_table(d1)
        elsif name_n <= 3
          nick_table = mk_nick_ou_table(d1)
        elsif name_n <= 4
          nick_table = mk_nick_ti_table(d1)
        elsif name_n <= 5
          nick_table = mk_nick_ph_table(d1)
        else
          nick_table = mk_nick_co_table(d1)
        end

        # 名前分岐
        if name_n <= 1
          name_table = mk_name_ar_table(d2)
        elsif name_n <= 2
          name_table = mk_name_fo_table(d2)
        elsif name_n <= 3
          name_table = mk_name_dn_table(d2)
        elsif name_n <= 4
          name_table = mk_name_pl_table(d2)
        elsif name_n <= 5
          name_table = mk_name_ma_table(d2)
        else
          name_table = mk_name_go_table(d2)
        end

        output = nick_table + name_table
        debug("output", output)
        dice = "#{nick_n},#{name_n},#{d1},#{d2}"

        return output, dice
      end

      # ことわざ系二つ名表
      def mk_nick_pr_table(num)
        table = [
          [11, "“九死に一生を得る”"],
          [12, "“風前の灯火の”"],
          [13, "“類は友を呼ぶ”"],
          [14, "“性格がいい方の”"],
          [15, "“三階に家なき”"],
          [16, "“五分の理はある”"],
          [22, "“危ない橋を渡る”"],
          [23, "“バカって言った方がバカの”"],
          [24, "“長いものに巻かれる”"],
          [25, "“火の無いところの”"],
          [26, "“あばたもえくぼの”"],
          [33, "“将を射んとせばまず”"],
          [34, "“氷山の一角の”"],
          [35, "“木乃伊取りが木乃伊になる”"],
          [36, "“一見の価値ありの”"],
          [44, "“一日の長ある”"],
          [45, "“遠くの親類より近くの”"],
          [46, "“笑う門には福来る”"],
          [55, "“花は桜木、人は”"],
          [56, "“猫に小判の”"],
          [66, "“（クラス名／ジョブ名）による（クラス名／ジョブ名）のための”"],
        ]
        return get_table_by_number(num, table)
      end

      # 四字熟語系二つ名表
      def mk_nick_fo_table(num)
        table = [
          [11, "“自画自賛（の）”"],
          [12, "“人畜無害（の）”"],
          [13, "“不言実行（の）”"],
          [14, "“痛快無比（の）”"],
          [15, "“外柔内剛（の）”"],
          [16, "“百戦錬磨（の）”"],
          [22, "“前代未聞（の）”"],
          [23, "“粉骨砕身（の）”"],
          [24, "“天真爛漫（の）”"],
          [25, "“暴飲暴食（の）”"],
          [26, "“意志薄弱（の）”"],
          [33, "“慇懃無礼（の）”"],
          [34, "“沈魚落雁（の）”"],
          [35, "“波乱万丈（の）”"],
          [36, "“二束三文（の）”"],
          [44, "“行雲流水（の）”"],
          [45, "“驚天動地（の）”"],
          [46, "“破邪顕正（の）”"],
          [55, "“以心伝心（の）”"],
          [56, "“博覧強記（の）”"],
          [66, "“殺人事件（の）”"],
        ]
        return get_table_by_number(num, table)
      end

      # 外見系二つ名表
      def mk_nick_ou_table(num)
        table = [
          [11, "“もふもふの”"],
          [12, "“裸の”"],
          [13, "“猫耳の”"],
          [14, "“歩くと音がする”"],
          [15, "“緑髪の”"],
          [16, "“黄金（の）”"],
          [22, "“羽根つき（の）”"],
          [23, "“小さな”"],
          [24, "“蛇手の”"],
          [25, "“鉤シッポの”"],
          [26, "“ぎざぎざの”"],
          [33, "“輝ける”"],
          [34, "“角持ち（の）”"],
          [35, "“とんがり帽子の”"],
          [36, "“青ざめた”"],
          [44, "“赤目の”"],
          [45, "“黒衣の”"],
          [46, "“ねじれ声の”"],
          [55, "“銀の腕”"],
          [56, "“長靴下の”"],
          [66, "“ぬるぬるの”"],
        ]
        return get_table_by_number(num, table)
      end

      # 称号系二つ名表
      def mk_nick_ti_table(num)
        table = [
          [11, "“（王国名）の星”"],
          [12, "“（王国名）の独眼竜”"],
          [13, "“（王国名）の麒麟児”"],
          [14, "“（王国名）の虎”"],
          [15, "“（王国名）のマムシ”"],
          [16, "“（王国名）１Ｄ６天王”"],
          [22, "“（王国名）１Ｄ６傑”"],
          [23, "“（王国名）１Ｄ６銃士”"],
          [24, "“（王国名）１０＋１Ｄ６神将”"],
          [25, "“（王国名）２Ｄ６（兄弟／姉妹）”"],
          [26, "“（王国名）２Ｄ６賢人”"],
          [33, "“あの（クラス名／ジョブ名）”"],
          [34, "“最後の（クラス名／ジョブ名）”"],
          [35, "“メカ（クラス名／ジョブ名）”"],
          [36, "“殺人（クラス名／ジョブ名）”"],
          [44, "“カリスマ（クラス名／ジョブ名）”"],
          [45, "“超級（クラス名／ジョブ名）”"],
          [46, "“攻め（クラス名／ジョブ名）”"],
          [55, "“スタイリッシュ（クラス名／ジョブ名）”"],
          [56, "“大（クラス名／ジョブ名）”"],
          [66, "“鬼（クラス名／ジョブ名）”"],
        ]
        return get_table_by_number(num, table)
      end

      # 名文句系二つ名表
      def mk_nick_ph_table(num)
        table = [
          [11, "“世界が嫉妬する”"],
          [12, "“うまい、うますぎる”"],
          [13, "“２４時間戦える”"],
          [14, "“脱いでもすごい”"],
          [15, "“ピカピカの１年生”"],
          [16, "“どうあがいても絶望の”"],
          [22, "“ダメ絶対の”"],
          [23, "“すべての王国を過去にする”"],
          [24, "“１００人乗っても大丈夫な”"],
          [25, "“綺麗なおねえさんが好きな”"],
          [26, "“食う寝る遊ぶの”"],
          [33, "“かわいいは正義の”"],
          [34, "“それにつけても”"],
          [35, "“お口の恋人”"],
          [36, "“やめられない止まらない”"],
          [44, "“半分はやさしさの”"],
          [45, "“国民的美少女”"],
          [46, "“プライスレスの”"],
          [55, "“驚きの白さの”"],
          [56, "“楽器のマークの”"],
          [66, "“パンツじゃないから恥ずかしくない”"],
        ]
        return get_table_by_number(num, table)
      end

      # かっこいい系二つ名表
      def mk_nick_co_table(num)
        table = [
          [11, "“（王国名／氷）の牙”"],
          [12, "“（王国名／不可視）の猟犬”"],
          [13, "“（王国名／暴虐）の女神”"],
          [14, "“（王国名／無限）の境界”"],
          [15, "“（王国名／偽り）の救世主”"],
          [16, "“（王国名／闇）の扉”"],
          [22, "“（王国名／暁）の凶星”"],
          [23, "“（王国名／災禍）の中心”"],
          [24, "“（王国名／始まり）の記憶”"],
          [25, "“（王国名／絶対）の歌声”"],
          [26, "“（王国名／星霜）の死神”"],
          [33, "“（王国名／不確定）の隠者”"],
          [34, "“（王国名／冥府）の番人”"],
          [35, "“（王国名／深淵）の使途”"],
          [36, "“（王国名／罪）の華”"],
          [44, "“（王国名／終末）の翼”"],
          [45, "“（王国名／絶望）の匠”"],
          [46, "“（王国名／鮮血）の芸術家”"],
          [55, "“（王国名／流星）の魔剣”"],
          [56, "“（王国名／漆黒）の堕天使”"],
          [66, "“（王国名／無貌）の悪夢”"],
        ]
        return get_table_by_number(num, table)
      end

      # 芸術系名前表(D66)
      def mk_name_ar_table(num)
        table = [
          [11, "コーラス／メロディ"],
          [12, "シタール／コト"],
          [13, "トロンボーン／ティンパニ"],
          [14, "マーチ／セレナーデ"],
          [15, "ソロ／オーケストラ"],
          [16, "パッソ／プリマ"],
          [22, "モノローグ／アポローズ"],
          [23, "スクリプト／カメリーノ"],
          [24, "アール／エピカ"],
          [25, "ラインズ／ムジカ"],
          [26, "トルバドール／リリカ"],
          [33, "ノベル／ラマーン"],
          [34, "クリーミ／ストーリア"],
          [35, "エッセイ／メモワール"],
          [36, "ジャケット／コロフォン"],
          [44, "デビュー／セーヌ"],
          [45, "タンゴ／バル"],
          [46, "イーゼル／パレット"],
          [55, "カンバス／タトゥー"],
          [56, "ウッドカット／キラーミカ"],
          [66, "ポートレイト／パノラマ"],
        ]
        return get_table_by_number(num, table)
      end

      # 食べ物系名前表(D66)
      def mk_name_fo_table(num)
        table = [
          [11, "ダージリン／マンデリン"],
          [12, "コニャック／ピーノ"],
          [13, "グラス／テキーラ"],
          [14, "ハングオーバー／リキュール"],
          [15, "ブレッド／プレッツェル"],
          [16, "バケット／コロネ"],
          [22, "クロワッサン／ヤムチャ"],
          [23, "ヤキソバ／パッタイ"],
          [24, "ニョッキ／ペンネ"],
          [25, "ハニー／メイプル"],
          [26, "ガトー／フラン"],
          [33, "ジュレ／ソルベ"],
          [34, "リゾット／チマキ"],
          [35, "フリット／テンプラ"],
          [36, "カルビ／ハラミ"],
          [44, "ポージョ／ユーリンチー"],
          [45, "アイスバイン／イベリコ"],
          [46, "ブルスト／キシュカ"],
          [55, "ドリアン／キウィ"],
          [56, "ココ／プラム"],
          [66, "ガリガリ／ポテチ"],
        ]
        return get_table_by_number(num, table)
      end

      # 日用品系名前表(D66)
      def mk_name_dn_table(num)
        table = [
          [11, "ファイバー／シルク"],
          [12, "ジーンズ／キュロット"],
          [13, "ガーター／ソックス"],
          [14, "クラヴァッテ／スカーフ"],
          [15, "サンダル／ハイヒール"],
          [16, "リング／ブローチ"],
          [22, "ボタン／リカーモ"],
          [23, "シュピーゲル／ルージュ"],
          [24, "オーデコロン／マニキュア"],
          [25, "シルクハット／サリー"],
          [26, "ソープ／コーム"],
          [33, "スツール／ソファー"],
          [34, "ブランケット／マクラ"],
          [35, "ケトル／ポット"],
          [36, "ゲイト／ポーチ"],
          [44, "ギムレット／レンチ"],
          [45, "シェイヴァー／シャンプー"],
          [46, "タオル／マスカラ"],
          [55, "クローゼット／クッション"],
          [56, "カウチ／クリップ"],
          [66, "スタンプ／カレンダー"],
        ]
        return get_table_by_number(num, table)
      end

      # 地名系名前表(D66)
      def mk_name_pl_table(num)
        table = [
          [11, "シアトル／ヴァージニア"],
          [12, "デーン／ヴァーサ"],
          [13, "タイガ／ユルガ"],
          [14, "クルスク／トゥール"],
          [15, "アラド／モルダヴィア"],
          [16, "キエフ／ユークレイン"],
          [22, "ウガンダ／ガーナ"],
          [23, "ギザ／アレクサンドリア"],
          [24, "キリマンジャロ／ソマリ"],
          [25, "ガイアナ／リオ"],
          [26, "イグアス／アマゾン"],
          [33, "サンティアゴ／ナスカ"],
          [34, "クーロン／シャンハイ"],
          [35, "ベナレス／デリー"],
          [36, "バリ／セイロン"],
          [44, "ティモール／スマトラ"],
          [45, "トリノ／シチリア"],
          [46, "バスク／グラナダ"],
          [55, "キプロス／クレタ"],
          [56, "ザクセン／ケルン"],
          [66, "リヨン／ニース"],
        ]
        return get_table_by_number(num, table)
      end

      # 機械系名前表(D66)
      def mk_name_ma_table(num)
        table = [
          [11, "ウォッチ／シーナ"],
          [12, "アンテナ／テレ"],
          [13, "グリル／バティドーラ"],
          [14, "ステレオ／カリヨン"],
          [15, "マキナ／アルマ"],
          [16, "ロケット／ヴィルタリオート"],
          [22, "ルー／フラン"],
          [23, "モーター／モトーレ"],
          [24, "ドライラート／コーチェ"],
          [25, "クロック／セニャーレ"],
          [26, "ポンプ／アントリア"],
          [33, "スケイルズ／プランチャ"],
          [34, "ランプ／シャンデリア"],
          [35, "ガジエラ／カノン"],
          [36, "リフト／エクレール"],
          [44, "ナルキ／プランタ"],
          [45, "サカプンタス／アーラ"],
          [46, "シュレッダー／ナウス"],
          [55, "ファブリーク／ユジーヌ"],
          [56, "ボイラー／カルダイヤ"],
          [66, "エンジン／トリシクル"],
        ]
        return get_table_by_number(num, table)
      end

      # 神様系名前表(D66)
      def mk_name_go_table(num)
        table = [
          [11, "ケルヌンノス／アリアンロッド"],
          [12, "ジーザス／マリア"],
          [13, "ブッダ／スジャータ"],
          [14, "ゼウス／ヘラ"],
          [15, "シヴァ／パールヴァティ"],
          [16, "マルス／ミネルヴァ"],
          [22, "スサノオ／ウズメ"],
          [23, "バンコ／ジョカ"],
          [24, "インティ／パチャママ"],
          [25, "ダグザ／モリガン"],
          [26, "バロン／ランダ"],
          [33, "アヌビス／バステト"],
          [34, "ジャンゴ／アナンシ"],
          [35, "トラロック／コアトリクエ"],
          [36, "バアル／アシュタルテ"],
          [44, "アフラマズダ／アムルタート"],
          [45, "ベロボーグ／モコシ"],
          [46, "エンキ／イナンナ"],
          [55, "オーディン／フレイヤ"],
          [56, "ココペリ／ココペルマナ"],
          [66, "クトゥルフ／ハイドラ"],
        ]
        return get_table_by_number(num, table)
      end
    end
  end
end
