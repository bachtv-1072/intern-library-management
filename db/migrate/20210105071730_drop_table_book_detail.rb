class DropTableBookDetail < ActiveRecord::Migration[6.0]
  def change
    drop_table :book_details
  end
end
