class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.references :report, index: true
      t.string :line

      t.timestamps
    end
  end
end
