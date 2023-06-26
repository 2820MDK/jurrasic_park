# == Schema Information
#
# Table name: cages
#
#  id         :bigint           not null, primary key
#  capacity   :integer          not null
#  has_power  :boolean          default(TRUE)
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Cage, type: :model do
	before :all do
		@tyran = FactoryBot.create(:species, name: "Tyrannosaurus")
		@velo = FactoryBot.create(:species, name: "Velociraptor")
	end

	context 'validations' do
		it 'must have dinosaurs of the same species' do
			dino1 = FactoryBot.create(:dinosaur, species: @tyran)
			dino2 = FactoryBot.create(:dinosaur, species: @velo)
			cage = FactoryBot.build :cage, capacity: 10
			cage.dinosaurs << dino1
			expect(cage).to be_valid
			cage.save!

			cage.dinosaurs << dino2
			expect(cage).not_to be_valid
		end

		it 'must have dinosaurs at or below capacity number' do
			dino1 = FactoryBot.create(:dinosaur, species: @velo)
			dino2 = FactoryBot.create(:dinosaur, species: @velo)
			cage = FactoryBot.build :cage, capacity: 1
			cage.dinosaurs << dino1
			expect(cage).to be_valid
			cage.save!

			cage.dinosaurs << dino2
			expect(cage).not_to be_valid
		end

    it 'cant turn off cage with dinos' do
      cage = FactoryBot.build :cage, capacity: 10
      dino2 = FactoryBot.create(:dinosaur, species: @velo, cage: cage)
      expect(cage).to be_valid

      cage.has_power = false
      expect(cage).not_to be_valid
    end
	end
end
