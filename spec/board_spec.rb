require 'spec_helper'

describe 'Board' do

  before :each do
    @board = Board.new(3)
    @player_x = MockPlayer.new('X', @board)
    @player_o = MockPlayer.new('O', @board)
    @board.add_marker(@player_x.marker, '1B')
  end

  describe '#create_board_hash' do
    it 'creates an empty board hash' do
      board = Board.new(3)
      (board.all_cells).should == { '1A' => nil, '2A' => nil, '3A' => nil,
                                    '1B' => nil, '2B' => nil, '3B' => nil,
                                    '1C' => nil, '2C' => nil, '3C' => nil }
    end
  end

  describe '#get_winning_lines' do
    it 'creates an empty board hash' do
      board = Board.new(3)
      (board.winning_lines).should == [['1A', '2A', '3A'],
                                       ['1B', '2B', '3B'],
                                       ['1C', '2C', '3C'],
                                       ['1A', '1B', '1C'],
                                       ['2A', '2B', '2C'],
                                       ['3A', '3B', '3C'],
                                       ['1A', '2B', '3C'],
                                       ['3A', '2B', '1C']]
    end
  end

  describe '#add_marker' do
    it "adds player's marker to the board" do
      @board.add_marker(@player_x.marker, '1A')
      @board.all_cells['1A'].should == 'X'
    end

    it "adds player's marker to the board" do
      @board.add_marker(@player_o.marker, '1B')
      @board.all_cells['1B'].should == 'O'
    end
  end

  describe '#winner? returns correct boolean value' do
    [
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => 'O', '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'O', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'O', '3A' => 'O',
         '1B' => nil, '2B' => 'X', '3B' => 'X',
         '1C' => nil, '2C' => nil, '3C' => nil }, true],
      [{ '1A' => 'O', '2A' => 'X', '3A' => 'O',
         '1B' => 'O', '2B' => 'O', '3B' => 'X',
         '1C' => 'X', '2C' => 'X', '3C' => 'O' }, true],
      [{ '1A' => nil, '2A' => 'X', '3A' => 'O',
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => nil, '3C' => nil }, false],
      [{ '1A' => 'O', '2A' => 'X', '3A' => nil,
         '1B' => 'X', '2B' => nil, '3B' => 'X',
         '1C' => 'O', '2C' => 'X', '3C' => nil }, false]
    ].each do |board_all_cells, expected_outcome|
      it "gets #{board_all_cells} and returns #{expected_outcome}" do
        @board.all_cells = board_all_cells
        @board.winner?(@player_o.marker).should == expected_outcome
      end
    end
  end

  describe '#game_over?' do
    it "returns true for win" do
      @board.all_cells = {
        "1A"=> 'O', "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @board.game_over?.should be_true
    end

    it "returns false for neither win nor tie" do
      @board.all_cells = {
        "1A"=> nil, "2A"=>'O', "3A"=>'O',
        "1B"=> nil, "2B"=>'X', "3B"=> 'X',
        "1C"=> nil, "2C"=>nil, "3C"=> nil
      }
      @board.game_over?.should be_false
    end

    it "returns true for tie" do
      @board.all_cells = {
        "1A"=> 'X', "2A"=>'O', "3A"=>'O',
        "1B"=> 'O', "2B"=>'X', "3B"=> 'X',
        "1C"=> 'X', "2C"=>'O', "3C"=> 'X'
      }
      @board.game_over?.should be_true
    end
  end

  describe '#available_cell?' do
    it "returns true if the cell is empty" do
      @board.available_cell?('1A').should be_true
    end

    it "returns false if the cell is not empty" do
      @board.available_cell?('1B').should be_false
    end

    it "returns false if the cell ID is invalid" do
      @board.available_cell?('test').should be_false
    end
  end

  describe '#valid_cell?' do
    it "returns false if the cell is invalid" do
      @board.valid_cell?('test').should be_false
    end

    it "returns true if the cell is valid" do
      @board.valid_cell?('1B').should be_true
    end

    it "returns true if the cell is valid" do
      @board.valid_cell?('1A').should be_true
    end
  end

  describe '#remove_marker' do
    it "removes player's marker from the board" do
      @board.remove_marker('1B')
      @board.all_cells['1B'].should be_nil
    end
  end

  describe '#moves_remaining?' do
    it "returns false if board is full" do
      @board.all_cells = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => 'X' }
      @board.moves_remaining?.should be_false
    end

    it "returns true if board is not full" do
      @board.all_cells = { '1A' => 'X', '2A' => 'O', '3A' => 'X',
                       '1B' => "O", '2B' => 'O', '3B' => 'X',
                       '1C' => 'X', '2C' => 'O', '3C' => nil }
      @board.moves_remaining?.should be_true
    end
  end

  describe '#open_cells' do
    before :each do
      @board = Board.new(3)
      @player_x = MockPlayer.new('X', @board)
      @player_o = MockPlayer.new('O', @board)
    end

    it "gets hash of cell IDs of open positions" do
      @board.open_cells.should == {"1A"=>nil, "2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @board.add_marker(@player_x.marker, "1A")
      @board.open_cells.should == {"2A"=>nil, "3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end

    it "gets hash of cell IDs of open positions" do
      @board.add_marker(@player_x.marker, "1A")
      @board.add_marker(@player_o.marker, "2A")
      @board.open_cells.should == {"3A"=>nil, "1B"=>nil, "2B"=>nil, "3B"=>nil, "1C"=>nil, "2C"=>nil, "3C"=>nil}
    end
  end

  describe '#open_cells' do
    it "gets hash of cell IDs of open positions" do
      @board.all_cells = { '1A' => 'X', '2A' => nil, '3A' => nil,
                           '1B' => 'O', '2B' => 'X', '3B' => nil,
                           '1C' => 'X', '2C' => 'O', '3C' => 'O' }
      @board.open_cells.should == {'2A' => nil, '3A' => nil, '3B' => nil}
    end

    it "gets hash of cell IDs of open positions" do
      @board.all_cells = { '1A' => 'X', '2A' =>'X', '3A' => nil,
                           '1B' => 'O', '2B' => 'X', '3B' => nil,
                           '1C' => nil, '2C' => 'O', '3C' => 'O' }
      @board.open_cells.should == {'3A' => nil, '3B' => nil, '1C' => nil}
    end

    it "returns empty hash when there's no open positions" do
      @board.all_cells = { '1A' => 'X', '2A' =>'X', '3A' => 'O',
                           '1B' => 'O', '2B' => 'X', '3B' => 'X',
                           '1C' => 'O', '2C' => 'O', '3C' => 'O' }
      @board.open_cells.should == {}
    end
  end

  describe '#empty?' do
    it "returns false when there are open cells" do
      @board.empty?.should be_false
    end
    it "returns true when there are no open cells" do
      board = Board.new(3)
      board.empty?.should be_true
    end
  end

  describe '#random_cell' do
    it "returns cell ID string of an open cell" do
      @board.all_cells = { '1A' => 'X', '2A' => nil, '3A' => nil,
                           '1B' => 'O', '2B' => 'X', '3B' => nil,
                           '1C' => 'X', '2C' => 'O', '3C' => 'O' }
      random_ID = @board.random_cell
      ['2A', '3A', '3B'].include?(random_ID)
    end

    it "does not return cell ID of an occupied cell" do
      @board.all_cells = { '1A' => nil, '2A' => nil, '3A' => nil,
                           '1B' => nil, '2B' => nil, '3B' => nil,
                           '1C' => 'X', '2C' => 'O', '3C' => 'O' }
      random_ID = @board.random_cell
      ['1C', '2C', '3C'].include?(random_ID)
    end
  end

end