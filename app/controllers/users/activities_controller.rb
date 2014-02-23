class Users::ActivitiesController < ApplicationController
  decorate_with ActivityDecorator
  respond_to :js

  def complete
    if resource.update permited_params.merge(status: :completed)
      respond_with(resource) do |format|
        format.html { render :next_activity }
        format.js   { render 'next_activity.js.erb', layout: false }
      end
    else
      flash.now[:danger] = "Something went wrong: #{resource.errors.full_messages.to_sentence}"
      respond_with(resource) do |format|
        format.html { render :show }
        format.js   { render 'shared/js/form_errors.js.erb', layout: false }
      end
    end
  end

  def fail
    if resource.update status: :failed
      respond_with(resource) do |format|
        format.html { render :next_activity }
        format.js   { render 'next_activity.js.erb', layout: false }
      end
    else
      flash.now[:danger] = 'Something went wrong'
      respond_with(resource) do |format|
        format.html { render :show }
        format.js   { render 'shared/js/flash_messages.js.erb', layout: false }
      end
    end
  end

  def create_responder(format)
    if action_successful?
      format.html { render :show }
      format.js   { render 'create.js', layout: false }
    else
      format.html { render :show }
      format.js   { render 'shared/js/form_errors.js.erb', layout: false }
    end
  end

  def update_responder(format)
    if action_successful?
      format.html { render :show }
    end
  end

  permit_params :target_date, :completed_date, :type,
   :status, :notes, :address_id, :contact_id, :installation_id,
   installation_attributes: [:date, :kit_id, :contact_id, :address_id, :user_id]
end
