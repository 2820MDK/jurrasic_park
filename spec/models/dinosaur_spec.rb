require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
	context 'validations' do
		it 'must have a name' do
			dino = FactoryBot.build(:dinosaur, name: nil)
			expect(dino).to_not be_valid

			dino.name = 'Trae Young'
			expect(dino).to be_valid
		end
	end

	context 'diets' do
		before :each do
			tyrannosaurus = FactoryBot.create(:species, name: "Tyrannosaurus", diet: :carnivore)
			brachiosaurus = FactoryBot.create(:species, name: "Brachiosaurus", diet: :herbivore)
			@karl = FactoryBot.create(:dinosaur, species: tyrannosaurus, name: 'Karl Malone')
			@john = FactoryBot.create(:dinosaur, species: brachiosaurus, name: 'John Stockton')
		end

		context 'is_carniovre?' do
			it 'is true if diet is carniovre' do
				expect(@karl.is_carniovre?).to eq(true)
			end

			it 'is false if diet is herbivore' do
				expect(@john.is_carniovre?).to eq(false)
			end
		end

		context 'is_herbivore?' do
			it 'is false if diet is carniovre' do
				expect(@karl.is_herbivore?).to eq(false)
			end
	
			it 'is true if diet is herbivore' do
				expect(@john.is_herbivore?).to eq(true)
			end
		end
	end
end