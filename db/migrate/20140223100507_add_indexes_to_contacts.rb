class AddIndexesToContacts < ActiveRecord::Migration
  def change
    add_index :contacts, :first_name
    add_index :contacts, :last_name
    add_index :contacts, :email
  end
end
