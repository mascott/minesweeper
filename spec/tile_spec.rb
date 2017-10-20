require 'tile'

RSpec.describe Tile do
  describe '#revealed?' do
    it "returns true if the tile is visible" do
      tile = Tile.new
      tile.reveal

      expect(tile.revealed?).to eq true
    end

    it "returns false if the tile is not visible" do
      tile = Tile.new

      expect(tile.revealed?).to eq false
    end
  end

  describe '#click' do
    it "flips the revealed state to true" do
      tile = Tile.new
      expect(tile.revealed?).to eq false

      tile.reveal

      expect(tile.revealed?).to eq true
    end
  end

  describe '#flagged?' do
    it "returns true if the tile is flagged" do
      tile = Tile.new
      tile.flag!

      expect(tile.flagged?).to eq true
    end

    it "returns false if the tile is not flagged" do
      tile = Tile.new

      expect(tile.flagged?).to eq false
    end
  end

  describe '#flag!' do
    it "toggles the flagged state" do
      tile = Tile.new

      expect(tile.flagged?).to eq false

      tile.flag!

      expect(tile.flagged?).to eq true

      tile.flag!

      expect(tile.flagged?).to eq false
    end
  end

  describe '#to_s' do
    it "returns an _ when not revealed" do
      tile = Tile.new

      expect(tile.to_s).to eq "_"
    end

    it "returns an ? when flagged" do
      tile = Tile.new

      tile.flag!

      expect(tile.to_s).to eq "?"
    end

    context "when revealed tile is a value" do
      it "returns the value when greater than 0" do
        tile = Tile.new
        tile.increment

        tile.reveal

        expect(tile.to_s).to eq tile.value
      end

      it "returns EMPTY when 0" do
        tile = Tile.new

        tile.reveal

        expect(tile.to_s).to eq Tile::EMPTY
      end

    end
  end
end
