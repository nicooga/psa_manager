class Users::ColdLists::CallsController < InheritedResources::Base
  nested_belongs_to :user, :cold_list
  respond_to :html, :js

  has_scope :pending, type: :boolean
  has_scope :failed, type: :boolean
  has_scope :completed, type: :boolean

  def index
    index! do |format|
      format.js { render 'index.js.erb', layout: false, calls: collection }
    end
  end

  def create
    create! do |success, failure|
      success.js { render 'index.js.erb', layout: false }
      failure.js { render 'shared/js/form_errors', layout: false, object: resource }
    end
  end

  private

  def permitted_params
    params.permit call: [:status, :notes,
      phone_number_attributes: [:number, :kind]
    ]
  end
end
