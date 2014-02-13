class ChangeDefaultStatusForActivities < ActiveRecord::Migration
  def change
    change_column :activities, :status, :string, default: :pending
  end
end
