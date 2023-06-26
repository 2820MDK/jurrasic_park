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
FactoryBot.define do
	factory :species do
		name { "Test species"}
		diet { :herbivore }
  end
end
