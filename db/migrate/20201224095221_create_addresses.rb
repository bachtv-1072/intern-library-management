class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :street
      t.string :district
      t.string :province
      t.integer :user_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
