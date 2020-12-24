class CreateBookDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :book_details do |t|
      t.integer :book_id, foreign_key: true, null: false
      t.integer :author_id, foreign_key: true, null: false
      t.integer :publisher_id, foreign_key: true, null: false

      t.timestamps 
    end
  end
end
