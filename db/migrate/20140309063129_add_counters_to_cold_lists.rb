class AddCountersToColdLists < ActiveRecord::Migration
  def change
    add_column :cold_lists, :pending_calls_count, :integer, default: 0
    add_column :cold_lists, :failed_calls_count, :integer, default: 0
    add_column :cold_lists, :completed_calls_count, :integer, default: 0
  end
end
