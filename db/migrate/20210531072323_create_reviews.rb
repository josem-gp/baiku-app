class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.integer :votes
      t.references :user, null: false, foreign_key: true
      t.references :parking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
