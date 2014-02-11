class AddServicePeriodToProducts < ActiveRecord::Migration
  def change
    add_column :products, :service_period, :integer
  end
end
