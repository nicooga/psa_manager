class ActivitiesController < BaseController
  decorate_with ActivityDecorator
  belongs_to :current_user

  def create_responder(format)
    format.html do
      render :show
    end
  end

  permit_params :target_date, :completed_date, :type,
   :status, :notes, :address_id, :contact_id
end
