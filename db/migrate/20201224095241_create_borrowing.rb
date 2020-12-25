class CreateBorrowing < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowings do |t|
      t.datetime :date_borrow, index: true
      t.datetime :date_pay
      t.integer :status
      t.integer :user_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
