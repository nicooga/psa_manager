class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float :bonificable_points
      t.string :name
      t.money :list_price
      t.money :suggested_price

      t.timestamps
    end
  end
end
