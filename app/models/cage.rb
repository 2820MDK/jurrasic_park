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
class Cage < ApplicationRecord
	has_many :dinosaurs
	validate :dinosaurs_of_same_species, :max_dinosaur_count

	def has_dinosaurs?
		dinosaurs.count > 0
	end

	def dinosaurs_of_same_species
		if dinosaurs.pluck(:species_id).uniq.count > 1
			errors.add(:dinosaurs, "can't be with other species")
		end
	end

	def max_dinosaur_count
		if dinosaurs.count > capacity
			errors.add(:capacity, "can't have more dinosaurs")
		end
	end
end
