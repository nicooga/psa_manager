class CreateSocieties < ActiveRecord::Migration
  def change
    create_table :societies do |t|
      t.string :name
      t.text :description
      t.references :founder, index: true

      t.timestamps
    end
  end
end
