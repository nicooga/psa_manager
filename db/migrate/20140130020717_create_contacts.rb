class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :birthday
      t.text :notes
      t.references :user, index: true

      t.timestamps
    end
  end
end
