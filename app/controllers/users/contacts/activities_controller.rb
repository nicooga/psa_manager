class Users::Contacts::ActivitiesController < ApplicationController
  decorate_with ActivityDecorator

  has_scope :pending, type: :boolean
  has_scope :failed, type: :boolean
  has_scope :completed, type: :boolean

  def prepare_collection(c)
    decorate_collection(
      apply_scopes(c).page(params[:activities_page]).per(10)
    )
  end

  def create_responder(format)
    format.js do
      if action_successful?
        render 'users/contacts/activities/create.js', layout: false
      else
        render 'shared/js/form_errors', layout: false,
          locals: { selector: :activity_errors }
      end
    end
  end

  def permited_params
    super.merge user: current_user
  end

  permit_params :target_date, :type, :address_id, :notes
end
