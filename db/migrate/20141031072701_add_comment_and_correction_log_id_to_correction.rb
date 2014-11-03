class AddCommentAndCorrectionLogIdToCorrection < ActiveRecord::Migration
  def change
  	add_column :corrections, :comment, :string
  	add_column :corrections, :correction_log_id, :integer
  	add_index :corrections, :correction_log_id
  end
end
