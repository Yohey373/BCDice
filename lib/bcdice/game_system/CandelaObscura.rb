# frozen_string_literal: true

module BCDice
    module GameSystem
      class CandelaObscura < Base
        # ゲームシステムの識別子
        ID = "CandelaObscura"
  
        # ゲームシステム名
        NAME = "Candela Obscura"
  
        # ゲームシステム名の読みがな
        SORT_KEY = "かんてらおふすきゆら"
  
        HELP_MESSAGE = <<~INFO_MESSAGE_TEXT
          ・判定
          　nCO　(n:ダイス数　n≦6)
          　n個のダイスを振り、結果を表示します。
          　nに0を指定すると、2個のダイスを振り、小さい方のダイスの結果を表示します。

          ・Gilded Actions
          　nGA　(n:ダイス数　n≦6)
          　n個のダイスを振り、1つ目のダイスの結果と最も大きいダイスの結果を表示します。
        INFO_MESSAGE_TEXT
  
        register_prefix('\d+CO', '\d+GA')
  
        def eval_game_system_specific_command(command)
          case command
          when /CO/i
            return roll_co(command)
          when /GA/i
            return roll_ga(command)
        end

        private

        def roll_co(command)
          m = /^(\d+)CO$/.match(command)
          return nil unless m

          times = m[1].to_i
          dice_list = @randomizer.roll_barabara(times, 6)

          result =
          if dice_list.count(6) >= 2
            "クリティカル"
          elsif dice_list.max == 6
            "完全成功"
          elsif dice_list.max >= 4
            "部分的成功"
          else
            "失敗"
          end

          return "(#{command}) ＞ #{dice_list} ＞ #{dice_list.max} ＞ #{result}"
        end

        def roll_ga(command)
          return "(#{command}) ＞ #{dice_list} ＞ #{dice_list.max} ＞ #{result}"
        end

      end
    end
  end
  