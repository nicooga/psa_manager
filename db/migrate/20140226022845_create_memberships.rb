class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :society, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
