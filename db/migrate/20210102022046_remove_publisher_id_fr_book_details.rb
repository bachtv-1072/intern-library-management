class RemovePublisherIdFrBookDetails < ActiveRecord::Migration[6.0]
  def change
    remove_column :book_details, :publisher_id, :integer
    add_column :books, :publisher_id, :integer, references: true
  end
end
