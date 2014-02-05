class MoveExpirationDateFromKitsToProducts < ActiveRecord::Migration
  def change
    remove_column :kits, :expiration_time
    add_column :products, :expiration_time, :integer
  end
end
