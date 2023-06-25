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
end
