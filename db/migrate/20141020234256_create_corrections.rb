class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.references :sentence, index: true
      t.string :advice
      t.references :advisor, index: true

      t.timestamps
    end
  end
end
