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
class Dinosaur < ApplicationRecord
	belongs_to :cage
	belongs_to :species

	validates :name, presence: true

	def is_carniovre?
		species.diet == "carnivore"
	end

	def is_herbivore?
		species.diet == "herbivore"
	end
end
