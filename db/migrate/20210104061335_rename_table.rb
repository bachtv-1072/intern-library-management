class RenameTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :athors, :authors
  end
end
