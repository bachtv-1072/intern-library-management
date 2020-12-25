class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name 
      t.string :email, unique: true
      t.string :password_digest
      t.date :birth
      t.string :phone_number
      t.integer :role

      t.timestamps 
    end
    add_index :users, :email, unique: true
  end
end
