class Users::ContactsController < InheritedResources::Base
  respond_to :html, :js
  belongs_to :user
  has_scope :with_pending_activities, type: :boolean

  def index
    index! do |format|
      format.js { render 'index.js.erb', layout: false }
    end
  end

  def show
    @activities = ActivityDecorator.decorate_collection(
      resource.activities
      .page(params[:activities_page]).per(10)
    )

    @installations = resource.installations
      .page(params[:installation_page]).per(10)
      .decorate

    show! do |format|
      format.json do
        render json: resource,
          methods: params[:scope].try(:[], :methods),
          only:    params[:scope].try(:[], :only),
          except:  params[:scope].try(:[], :except)
      end
      format.js { render 'contacts/show/show.js.erb', layout: false }
    end
  end

  private

  def resource_url() user_contact_path(id: resource.id) end
  def collection_url() user_contacts_path end
  def resource() super.decorate end

  def collection
    @q = apply_scopes(super).search(params[:q])
    @q.result.page(params[:page]).decorate
  end

  def permitted_params
    params.permit contact: [:first_name, :last_name, :email, :birthday, :notes, :source_id, :source_date,
      phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy],
      addresses_attributes: [:id, :city, :state, :street, :number, :apartment, :zip_code, :notes, :_destroy,
        phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]
      ]
    ]
  end
end
