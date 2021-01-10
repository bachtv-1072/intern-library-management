class CreateBorrowItems < ActiveRecord::Migration[6.0]
  def change
    create_table :borrow_items do |t|
      t.integer :quantity_borrowed
      t.references :book, type: :bigint
      t.references :borrowing, type: :bigint
      t.timestamps
    end
  end
end
