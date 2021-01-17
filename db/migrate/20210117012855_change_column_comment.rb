class ChangeColumnComment < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :user_id, :integer, null: true
    change_column :comments, :book_id, :integer, null: true
  end
end
