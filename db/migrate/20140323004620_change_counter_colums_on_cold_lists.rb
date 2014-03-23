class ChangeCounterColumsOnColdLists < ActiveRecord::Migration
  def change
    rename_column :cold_lists, :completed_calls_count, :positive_calls_count
    rename_column :cold_lists, :failed_calls_count, :negative_calls_count
    add_column    :cold_lists, :skipped_calls_count, :integer, default: 0

    Call.where(status: :completed).update_all status: :positive
    Call.where(status: :failed).update_all status: :negative
  end
end
