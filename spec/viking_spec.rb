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
        viking = Viking.new("Sven", 100, 10, current_weapon)

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
        viking = Viking.new("Sven", 100, 10, current_weapon)

        viking.drop_weapon
        expect(viking.weapon).to be_nil
      end

    end

  end # context: when handling weapons



  context "when fighting" do

    describe "#receive_attack" do

      it "reduces health by proper amount when attack received" do
        viking = Viking.new
        current_health = viking.health
        damage = 30
        expected_health = current_health - 30

        viking.receive_attack(damage)
        expect(viking.health).to eq(expected_health)
      end

      it "calls #take_damage when attack received" do
        viking = Viking.new
        expect(viking).to receive(:take_damage)

        viking.receive_attack(5)
      end

    end


    describe "#attack" do

      let(:attacker) { Viking.new } #unarmed
      let(:target) { Viking.new }

      it "causes target's health to drop" do
        current_health = target.health
        attacker.attack(target)
        expect(target.health).to be < current_health
      end


      it "calls #take_damage on the target viking" do
        expect(target).to receive(:take_damage)
        attacker.attack(target)
      end


      it "calls #damage_with_fists if unarmed" do
        expect(attacker).to receive(:damage_with_fists).and_return(5) # can return any number
        attacker.attack(target)
      end


      it "deals damage equal to Fist multipler * strength if unarmed" do
        strength = attacker.strength
        fists = Fists.new
        multipler = fists.use

        expect(target).to receive(:take_damage).with(strength * multipler)
        attacker.attack(target)
      end


      it "calls #damage_with_weapon if armed" do
        armed_attacker = Viking.new("Sven", 100, 10, Axe.new)

        expect(armed_attacker).to receive(:damage_with_weapon).and_return(5) # can return any number
        armed_attacker.attack(target)
      end


      it "deals damage equal to Weapon multipler * strength if armed" do
        armed_attacker = Viking.new("Sven", 100, 10, Axe.new)
        strength = armed_attacker.strength
        multipler = armed_attacker.weapon.use

        expect(target).to receive(:take_damage).with(strength * multipler)
        armed_attacker.attack(target)
      end

      it "uses Fists if bow equipped but zero arrows" do
        bow_attacker = Viking.new("Sven", 100, 10, Bow.new(0))

        expect(bow_attacker).to receive(:damage_with_fists).and_return(5) #can return any number
        bow_attacker.attack(target)
      end

    end

  end # context: when fighting



  context "when killing a viking" do

    describe "#check_death" do

      it "raises an error upon death" do
        dead_viking = Viking.new("Dead Sven", 100)
        expect { dead_viking.receive_attack(150) }.to raise_error("Dead Sven has Died...")
      end

    end

  end  #context: when killing


end