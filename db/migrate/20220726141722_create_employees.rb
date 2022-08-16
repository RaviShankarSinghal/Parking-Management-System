class CreateEmployees < ActiveRecord::Migration[7.0]
  def up
    create_table :employees do |t|
      t.string "name"
      t.string "email"
      t.string "password"
      t.integer "user_type"
      t.timestamps
    end
  end
  def down 
    drop_table :employees
  end
end
