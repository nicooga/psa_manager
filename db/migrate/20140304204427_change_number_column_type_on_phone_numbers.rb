class ChangeNumberColumnTypeOnPhoneNumbers < ActiveRecord::Migration
  def change
    change_column :phone_numbers, :number, 'integer USING CAST(number AS integer)'
  end
end
