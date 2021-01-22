class AddSortDeleteTables < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :deleted_at, :datetime
    add_index :books, :deleted_at
    add_column :borrowings, :deleted_at, :datetime
    add_index :borrowings, :deleted_at
    add_column :borrow_items, :deleted_at, :datetime
    add_index :borrow_items, :deleted_at
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
