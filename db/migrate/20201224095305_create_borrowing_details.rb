class CreateBorrowingDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowing_details do |t|
      t.datetime :date_pay, index: true
      t.integer :borrowing_id, foreign_key: true, null: false
      t.integer :user_id, foreign_key: true, null: false

      t.timestamps 
    end
  end
end
