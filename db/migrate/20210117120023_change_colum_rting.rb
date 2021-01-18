class ChangeColumRting < ActiveRecord::Migration[6.0]
  def change
    change_column :ratings, :user_id, :integer, null: true
    change_column :ratings, :book_id, :integer, null: true
  end
end
