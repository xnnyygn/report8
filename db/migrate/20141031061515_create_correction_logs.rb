class CreateCorrectionLogs < ActiveRecord::Migration
  def change
    create_table :correction_logs do |t|
      t.references :report, index: true
      t.references :advisor, index: true

      t.timestamps
    end
  end
end
