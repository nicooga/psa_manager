class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :target_date
      t.datetime :completed_date
      t.string :type
      t.string :status
      t.text :notes

      t.references :address
      t.references :contact
      t.references :user

      t.timestamps
    end
  end
end
