class CreateVechiles < ActiveRecord::Migration[7.0]
  def change
    create_table :vechiles do |t|
      t.string :number
      t.string :car_model_name
      t.integer :employee_id
      t.integer :parking_spots_id
      t.timestamps
    end
  end
end
