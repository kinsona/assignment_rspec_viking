require "weapons/bow"

describe Bow do


  describe "#arrows" do

    it "has readable arrow count" do
      bow = Bow.new
      expect(bow.arrows).to be_a(Integer)
    end

    it "starts with 10 arrows by default" do
      bow = Bow.new
      expect(bow.arrows).to eq(10)
    end

    it "starts with correct number of arrows when specified" do
      bow = Bow.new(15)
      expect(bow.arrows).to eq(15)
    end

  end


  describe "#use" do

    it "reduces arrow count by 1" do
      bow = Bow.new
      starting_arrows = bow.arrows
      expected_arrows = starting_arrows - 1
      bow.use
      expect(bow.arrows).to eq(expected_arrows)
    end

    it "throws an error if used with zero arrows" do
      bow = Bow.new(0)
      expect { bow.use }.to raise_error("Out of arrows")
    end

  end

end
