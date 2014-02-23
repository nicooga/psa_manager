class AddFieldsToInstallations < ActiveRecord::Migration
  def change
    change_table :installations do |t|
      t.date :warranty_expiration_date
      t.date :next_service_date
    end
  end
end
