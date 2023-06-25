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
end