class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :kind
      t.references :address, index: true
      t.references :contact, index: true

      t.timestamps
    end
  end
end
