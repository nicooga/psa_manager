class RenameKitsAquisitionDate < ActiveRecord::Migration
  def change
    rename_column :kits, :aquisition_date, :acquisition_date
  end
end
