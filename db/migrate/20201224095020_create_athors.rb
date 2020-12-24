class CreateAthors < ActiveRecord::Migration[6.0]
  def change
    create_table :athors do |t|
      t.string :name
      t.text :story
      t.string :birth

      t.timestamps 
    end
  end
end
