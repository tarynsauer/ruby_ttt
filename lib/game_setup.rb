require 'tictactoe_constants'

module RubyTictactoe

  class GameSetup
    include TictactoeConstants
    attr_accessor :ui
    def initialize
      @ui = UI.new
    end

    def get_settings
      {}
    end
  end

end