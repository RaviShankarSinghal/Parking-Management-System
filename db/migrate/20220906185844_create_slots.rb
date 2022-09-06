class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.references :floor, null: false, foreign_key: true
      t.string :slot_number
      t.integer :parking_status
      t.timestamps
    end
  end
end
