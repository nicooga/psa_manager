class CreateKits < ActiveRecord::Migration
  def change
    create_table :kits do |t|
      t.string :serial_number
      t.integer :expiration_time
      t.date :aquisition_date
      t.references :product, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
