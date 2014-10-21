class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :interface_language
      t.text :introduction
      t.references :department, index: true

      t.timestamps
    end
  end
end
