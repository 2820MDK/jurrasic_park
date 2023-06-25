FactoryBot.define do
	factory :dinosaur do
		name { "Test Dino"}
		cage { build(:cage) }
		species { build(:species) }
  end
end
