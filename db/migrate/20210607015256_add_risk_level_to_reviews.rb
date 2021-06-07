class AddRiskLevelToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :risk_level, :integer
  end
end
