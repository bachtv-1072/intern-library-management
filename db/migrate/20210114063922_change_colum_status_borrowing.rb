class ChangeColumStatusBorrowing < ActiveRecord::Migration[6.0]
  def change
    change_column :borrowings, :status, :integer, default: 0
  end
end
