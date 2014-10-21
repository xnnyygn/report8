class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.references :writer, index: true
      t.string :language
      t.text :content

      t.timestamps
    end
  end
end
