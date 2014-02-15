class AddInstallationReferencesToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :installation, index: true
  end
end
