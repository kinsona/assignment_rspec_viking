require "warmup"
describe Warmup do

  warmupper = Warmup.new

  describe "#gets_shout" do

    it "makes the input upcase" do
      allow(warmupper).to receive(:gets).and_return("i am shouting")
      expect(warmupper.gets_shout).to eq("I AM SHOUTING")
    end

  end


  describe "#double_size" do

    it "returns an integer 2x the array size" do
      tester = double(:size => 12)
      expect(tester).to receive(:size)

      expect(warmupper.double_size(tester)).to eq(24)
    end

  end


  describe "#calls_some_methods" do

    let(:tester) do
      instance_double("String", :upcase! => true, :reverse! => true)
    end

    it "receives #upcase! call" do
      expect(tester).to receive(:upcase!)
      warmupper.calls_some_methods(tester)
    end


    it "receives #reverse! call" do
      expect(tester).to receive(:reverse!)
      warmupper.calls_some_methods(tester)
    end


    it "returns a completely different input" do
      test_input = "new string"
      test_output = "GNIRTS WEN"

      expect(warmupper.calls_some_methods(test_input)).not_to eq(test_output)
      expect(warmupper.calls_some_methods(test_input)).not_to eq(test_input)
    end

  end

end