class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :book_id, foreign_key: true, null: false
      t.integer :user_id, foreign_key: true, null: false

      t.timestamps 
    end
  end
end
