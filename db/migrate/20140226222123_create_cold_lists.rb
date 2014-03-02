class CreateColdLists < ActiveRecord::Migration
  def change
    create_table :cold_lists do |t|
      t.references :user, index: true
      t.references :responsible, index: true
      t.integer :phone_number_prefix
      t.text :notes

      t.timestamps
    end
  end
end
