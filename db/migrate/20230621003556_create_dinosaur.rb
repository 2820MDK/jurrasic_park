class CreateDinosaur < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs do |t|
      t.belongs_to :cage
      t.belongs_to :species

      t.string :name, null: false
      t.timestamps
    end
  end
end
