class ChangeUserInBorrowing < ActiveRecord::Migration[6.0]
  def change
    change_column :borrowings, :user_id, :integer, null: true
  end
end
