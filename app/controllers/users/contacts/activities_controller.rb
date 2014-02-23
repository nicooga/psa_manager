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
end
