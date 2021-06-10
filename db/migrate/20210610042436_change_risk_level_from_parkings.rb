class ChangeRiskLevelFromParkings < ActiveRecord::Migration[6.0]
  def change
    change_column_default :parkings, :risk_level, 0
  end
end
