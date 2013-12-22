require 'spec_helper'

describe 'AI' do

  before :each do
    @board = Board.new(3)
    @player_x = AIPlayer.new('X')
    @player_o = HumanPlayer.new('O')
    @player_x.opponent = @player_o
    @player_o.opponent = @player_x
    @ai = AI.new(@player_x)
  end

  describe '#computer_move' do
    it "returns a cell ID string" do
      @board.all_cells = {
        "1A"=> 'O', "2A"=>'X', "3A"=>'X',
        "1B"=> nil, "2B"=>'O', "3B"=> 'O',
        "1C"=> nil, "2C"=>nil, "3C"=> 'X'
      }
      best_move = @ai.computer_move(@board, @player_x)
      best_move.length.should == 2
    end
  end

  describe '#get_best_move' do
    it "takes winning space when one is available" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'X', "3A"=>'X',
        "1B"=> nil, "2B"=>'O', "3B"=> 'O',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1A"
    end

    it "takes winning space when one is available" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'X',
        "1B"=> nil, "2B"=>'X', "3B"=> 'O',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1C"
    end

    it "blocks opponent win" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> "O", "2B"=>'X', "3B"=> 'X',
        "1C"=> "X", "2C"=>"O", "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1A"
    end

    it "blocks opponent win" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> "O", "2B"=>'X', "3B"=> 'X',
        "1C"=> "X", "2C"=>"O", "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1A"
    end

    it "chooses win over block" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> "X", "2C"=>"O", "3C"=> 'O'
      }
      @ai.get_best_move(@board, @player_x).should == "1B"
    end

    it "chooses win over block or non-win" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> "X", "2C"=>nil, "3C"=> 'O'
      }
      @ai.get_best_move(@board, @player_x).should == "1B"
    end

    it "chooses block over multiple non-wins" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>nil, "3B"=> 'X',
        "1C"=> "X", "2C"=>nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1A"
    end

    it "chooses corner when with one non-corner move on the board" do
      @board.all_cells = {
        "1A"=> nil, "2A"=> nil, "3A"=> nil,
        "1B"=> nil, "2B"=> 'O', "3B"=> nil,
        "1C"=> nil, "2C"=> nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == ("1A" || "3A" || "1C" || "3C")
    end

    it "chooses corner when with one non-corner move on the board" do
      @board.all_cells = {
        "1A"=> nil, "2A"=> 'O', "3A"=> nil,
        "1B"=> nil, "2B"=> nil, "3B"=> nil,
        "1C"=> nil, "2C"=> nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == ("1A" || "3A" || "1C" || "3C")
    end

    it "chooses win when same cell is block and win" do
      @board.all_cells = {
        "1A"=> nil, "2A"=> 'O', "3A"=> 'O',
        "1B"=> nil, "2B"=> 'X', "3B"=> nil,
        "1C"=> nil, "2C"=> 'O', "3C"=> 'X'
      }
      @ai.get_best_move(@board, @player_x).should == "1A"
    end

    it "chooses center cell for the win" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=> 'O', "3A"=> 'O',
        "1B"=> nil, "2B"=> nil, "3B"=> nil,
        "1C"=> nil, "2C"=> 'O', "3C"=> 'X'
      }
      @ai.get_best_move(@board, @player_x).should == "2B"
    end
  end

  describe '#get_best_move -- game walkthrough' do
    it "chooses pre-emptive block/win move" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=> nil, "3A"=> 'O',
        "1B"=> nil, "2B"=> nil, "3B"=> nil,
        "1C"=> nil, "2C"=> nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "1C"
    end

    it "chooses pre-emptive block/win move" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=> nil, "3A"=> 'O',
        "1B"=> 'O', "2B"=> nil, "3B"=> nil,
        "1C"=> 'X', "2C"=> nil, "3C"=> nil
      }
      @ai.get_best_move(@board, @player_x).should == "3C"
    end

    it "chooses win" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=> nil, "3A"=> 'O',
        "1B"=> 'O', "2B"=> nil, "3B"=> nil,
        "1C"=> 'X', "2C"=> 'O', "3C"=> 'X'
      }
      @ai.get_best_move(@board, @player_x).should == "2B"
    end

    it "chooses win" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=> nil, "3A"=> 'O',
        "1B"=> 'O', "2B"=> 'O', "3B"=> nil,
        "1C"=> 'X', "2C"=> nil, "3C"=> 'X'
      }
      @ai.get_best_move(@board, @player_x).should == "2C"
    end
  end

end