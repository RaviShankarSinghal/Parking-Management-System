class CreateFloors < ActiveRecord::Migration[7.0]
  def change
    create_table :floors do |t|
      t.integer :number
      t.integer :employee_id
      t.timestamps
    end
  end
end
