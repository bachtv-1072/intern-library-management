class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :point
      t.integer :book_id, foreign_key: true, null: false
      t.integer :user_id, foreign_key: true, null: false

      t.timestamps 
    end
  end
end
