require 'spec_helper'

describe 'RubyTictactoe::UI' do

  before :each do
    @ui = RubyTictactoe::UI.new
  end

  describe '#first_move_message' do
    it 'returns first move message string' do
      @ui.first_move_message('X').should == "Player 'X' goes first."
    end
  end

  describe '#next_move_message' do
    it 'returns next move message string' do
      @ui.next_move_message('X').should == "Player 'X': Make your move."
    end
  end

  describe '#winning_game_message' do
    it 'returns winning game message string' do
      @ui.winning_game_message('X').should == "GAME OVER! Player 'X' wins!"
    end
  end

  describe '#tie_game_message' do
    it 'returns tie game message string' do
      @ui.tie_game_message.should == "GAME OVER! It's a tie!"
    end
  end

end