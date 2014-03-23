class Users::ColdLists::CallsController < InheritedResources::Base
  nested_belongs_to :user, :cold_list
  respond_to :html, :js, :json

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
      success.js { render 'create.js.erb', layout: false }
      failure.js { render 'shared/js/form_errors', layout: false, object: resource }
    end
  end

  def destroy
    destroy! do |format|
      format.js { render 'index.js.erb', layout: false }
    end
  end

  def update
    update! do |format|
      format.json do
        render json: resource.decorate,
          methods: [:errors, :phone_number]
      end
    end
  end

  private

  def build_resource
    super.tap do |r|
      r.phone_number.contact.try(:user=, current_user)
    end
  end

  def permitted_params
    params.permit call: [:status, :notes,
      phone_number_attributes: [:id, :number, :kind,
        contact_attributes: [:id, :first_name, :last_name, :email, :birthday, :notes]
      ]
    ]
  end
end
