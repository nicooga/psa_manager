class ActivitiesController < BaseController
  belongs_to :current_user

  permit_params :target_date, :completed_date, :type,
   :status, :notes, :address_id, :contact_id
end
