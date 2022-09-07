class CreateVechiles < ActiveRecord::Migration[7.0]
  def change
    create_table :vechiles do |t|
      t.string :number
      t.string :car_model_name
      t.integer :price
      t.belongs_to :slot
      t.timestamps
    end
  end
end
