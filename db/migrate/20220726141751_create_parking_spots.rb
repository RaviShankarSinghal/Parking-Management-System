class CreateParkingSpots < ActiveRecord::Migration[7.0]
  def up
    create_table :parking_spots do |t|
      t.string "vehicle_no"
      t.integer "parking_palce"
      t.timestamps
    end
  end
  def down 
    drop_table :parking_spots
  end
end
