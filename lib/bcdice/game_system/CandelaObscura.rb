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
  
        register_prefix()
  
        def eval_game_system_specific_command(command)
          return nil
        end
      end
    end
  end
  