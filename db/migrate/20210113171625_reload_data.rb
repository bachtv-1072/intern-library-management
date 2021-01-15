class ReloadData < ActiveRecord::Migration[6.0]
  def change
    remove_column :borrow_items, :quantity_borrowed
    add_column :borrow_items, :user_id, :integer
    add_column :books, :quantity_borrowed, :integer
    add_column :borrowings, :borrow_code, :string, unique: true
    change_column :borrowings, :status, :integer, default: 0
  end
end
