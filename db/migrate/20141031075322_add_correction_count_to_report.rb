class AddCorrectionCountToReport < ActiveRecord::Migration
  def change
    add_column :reports, :correction_count, :integer, default: 0
  end
end
