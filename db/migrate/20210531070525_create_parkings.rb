class CreateParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
