class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.references :creator, index: true

      t.timestamps
    end
  end
end
