# == Schema Information
#
# Table name: species
#
#  id         :bigint           not null, primary key
#  diet       :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Species < ApplicationRecord
	has_many :dinosaurs
	enum status: {
		herbivore: 0,
		carnivore: 1,
	}
end
