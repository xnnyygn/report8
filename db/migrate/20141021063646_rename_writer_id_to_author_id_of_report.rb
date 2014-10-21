class RenameWriterIdToAuthorIdOfReport < ActiveRecord::Migration
  def change
  	rename_column :reports, :writer_id, :author_id
  end
end
