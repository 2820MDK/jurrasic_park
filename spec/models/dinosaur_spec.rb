# == Schema Information
#
# Table name: dinosaurs
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cage_id    :bigint
#  species_id :bigint
#
# Indexes
#
#  index_dinosaurs_on_cage_id     (cage_id)
#  index_dinosaurs_on_species_id  (species_id)
#
require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
	before :all do
		@tyrannosaurus = FactoryBot.create(:species, name: "Tyrannosaurus", diet: :carnivore)
		@brachiosaurus = FactoryBot.create(:species, name: "Brachiosaurus", diet: :herbivore)
	end

	context 'validations' do
		it 'must have a name' do
			dino = FactoryBot.build(:dinosaur, name: nil)
			expect(dino).to_not be_valid

			dino.name = 'Trae Young'
			expect(dino).to be_valid
		end

		it 'must be in a cage with same species' do
			cage = FactoryBot.create(:cage)
			dino1 = FactoryBot.create(:dinosaur, species: @tyrannosaurus, cage: cage)
			expect(dino1).to be_valid

			dino2 = FactoryBot.build(:dinosaur, species: @brachiosaurus, cage: cage)
			expect(dino2).not_to be_valid
		end
	end

	context 'before save' do
		it 'must be in a a cage with space' do
			cage = FactoryBot.create(:cage, capacity: 1)
			dino1 = FactoryBot.create(:dinosaur, species: @brachiosaurus, cage: cage)
			expect(dino1).to be_valid

			dino2 = FactoryBot.build(:dinosaur, species: @brachiosaurus, cage: cage)
			dino2.save
			expect(dino2.errors.full_messages.first).to eq("Cage can't have more dinosaurs")
		end
	end

	context 'diets' do
		before :each do
			@karl = FactoryBot.create(:dinosaur, species: @tyrannosaurus, name: 'Karl Malone', cage: FactoryBot.create(:cage, name: "Cage1"))
			@john = FactoryBot.create(:dinosaur, species: @brachiosaurus, name: 'John Stockton', cage: FactoryBot.create(:cage, name: "Cage2"))
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
