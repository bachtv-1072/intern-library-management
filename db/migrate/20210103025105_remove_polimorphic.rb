class RemovePolimorphic < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :imageable_id, :integer
    remove_column :images, :imageable_type, :string
    add_column :images, :book_id, :integer, references: true, null: false
  end
end
