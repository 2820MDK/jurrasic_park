class CreateCages < ActiveRecord::Migration[7.0]
  def change
    create_table :cages do |t|
      t.string :name,       null: false
      t.integer :capacity,  null: false
      t.boolean :has_power, default: true
      t.timestamps
    end
  end
end
