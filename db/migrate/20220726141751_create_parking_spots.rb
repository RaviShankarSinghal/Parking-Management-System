class CreateParkingSpots < ActiveRecord::Migration[7.0]
  def up
    create_table :parking_spots do |t|
      t.integer "status"
      t.timestamps
    end
  end
  def down 
    drop_table :parking_spots
  end
end
