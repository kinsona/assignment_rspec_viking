require "viking"

describe Viking do

  context "when created" do

    it "can set name when created" do
      test_name = "Olaf"
      viking = Viking.new(test_name)
      expect(viking.name).to eq(test_name)
    end


    it "can set health when created" do
      test_health = 150
      viking = Viking.new("Sven", test_health)
      expect(viking.health).to eq(test_health)
    end


    it "cannot overwrite health after initialize" do
      viking = Viking.new
      expect { viking.health = 120 }.to raise_error
    end


    it "starts with nil for default weapon" do
      viking = Viking.new
      expect(viking.weapon).to be_nil
    end

  end  # context: when created



  context "when handling weapons" do

      describe "#pick_up_weapon" do

      #before(:each) do
      #  let(:viking) { Viking.new }
      #end

      it "sets weapon when picked up" do
        viking = Viking.new
        new_weapon = Axe.new
        viking.pick_up_weapon(new_weapon)
        expect(viking.weapon).to be(new_weapon)
      end


      it "raises exception when picking up a non-weapon" do
        viking = Viking.new
        expect { viking.pick_up_weapon("fish") }.to raise_error("Can't pick up that thing")
      end

      it "replaces current weapon upon picking up a new one" do
        current_weapon = Axe.new
        viking = Viking.new("Sven", 100, 100, current_weapon)

        expect(viking.weapon).to eq(current_weapon)

        new_weapon = Bow.new
        viking.pick_up_weapon(new_weapon)

        expect(viking.weapon).not_to eq(current_weapon)
        expect(viking.weapon).to eq(new_weapon)
      end

    end


    describe "#drop_weapon" do

      it "sets weapon to nil upon dropping current weapon" do
        current_weapon = Axe.new
        viking = Viking.new("Sven", 100, 100, current_weapon)

        viking.drop_weapon
        expect(viking.weapon).to be_nil
      end

    end

  end # context: when handling weapons


end