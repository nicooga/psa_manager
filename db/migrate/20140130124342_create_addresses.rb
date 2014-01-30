class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :street
      t.integer :number
      t.string :apartment
      t.string :zip_code
      t.string :notes
      t.references :contact, index: true

      t.timestamps
    end
  end
end
