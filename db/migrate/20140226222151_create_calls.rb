class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.references :cold_list, index: true
      t.references :phone_number, index: true
      t.text :notes
      t.string :status, default: :pending

      t.timestamps
    end
  end
end
