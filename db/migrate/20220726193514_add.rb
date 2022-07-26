class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :emp_id, :integer
  end
end
