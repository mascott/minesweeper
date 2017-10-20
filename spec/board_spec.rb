require 'board'
require 'tile'


class MockTile < Tile
  def initialize()
    super
    @value = 1
  end
end

RSpec.describe Board do
  describe '#to_s' do
    context "when no guesses have been made" do
      it "returns a blanked out grid" do
        board = Board.new

        expect(board.to_s).to eq("_ _ _\n" \
                                 "_ _ _\n" \
                                 "_ _ _")
      end
    end
  end

  describe '#click!' do
    context "when location has a value greater than zero" do
      it "reveals the value" do
        board = Board.new(tile_class: MockTile)

        board.click!(x: 0, y: 0)

        expect(board.to_s).to eq("#{board.grid[0][0].to_s} _ _\n" \
                                 "_ _ _\n" \
                                 "_ _ _")
      end
    end

    context "when location has a value of zero" do
      it "reveals surrounding values" do
        board = Board.new()

        board.click!(x: 1, y: 1)

        expect(board.to_s).to eq("     \n" \
                                 "     \n" \
                                 "     ")
      end

      it "reveals full board" do
        board = Board.new()

        board.click!(x: 0, y: 0)

        expect(board.to_s).to eq("     \n" \
                                 "     \n" \
                                 "     ")
      end

      it "reveals full board" do
        board = Board.new()

        board.click!(x: 2, y: 2)

        expect(board.to_s).to eq("     \n" \
                                 "     \n" \
                                 "     ")
      end
    end
  end

  describe '#flag!' do
    it "toggles flag at location" do
      board = Board.new(mine_count: 1)

      board.flag!(x: 0, y: 0)

      expect(board.to_s).to eq("#{Tile::FLAG} _ _\n" \
                               "_ _ _\n" \
                               "_ _ _")

      board.flag!(x: 0, y: 0)

      expect(board.to_s).to eq("_ _ _\n" \
                               "_ _ _\n" \
                               "_ _ _")
    end

    context "when there are flags remaining" do
      it "decrements the flag count" do
        board = Board.new(mine_count: 1)
        board.flag!(x: 0, y: 0)

        expect(board.flag_count).to eq(0)
      end
    end
  end
end
