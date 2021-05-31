class CreateUserParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_parkings do |t|
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :parking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
