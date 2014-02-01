class AddSourceToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :source, index: true
    add_column :contacts, :source_date, :date
  end
end
