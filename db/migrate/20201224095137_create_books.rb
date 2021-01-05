class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.integer :category_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
