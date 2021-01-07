class AddColumnAuthorId < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :author_id, :integer, references: true, null: false
  end
end
