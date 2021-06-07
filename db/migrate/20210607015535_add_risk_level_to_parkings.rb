class AddRiskLevelToParkings < ActiveRecord::Migration[6.0]
  def change
    add_column :parkings, :risk_level, :integer
  end
end
