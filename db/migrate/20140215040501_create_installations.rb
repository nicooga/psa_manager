class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.date :date
      t.references :kit, index: true
      t.references :contact, index: true
      t.references :address, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
