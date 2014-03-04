class Users::ColdListsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :js

  has_scope(:assigned, type: :boolean) do |controller, scope|
    controller.send(:parent).assigned_cold_lists
  end

  def index
    index! do |format|
      format.js { render 'index.js.erb', layout: false }
    end
  end

  def update
    update! do |format|
      format.js do
        render 'users/cold_lists/calls/index.js.erb',
          layout: false, locals: { calls: resource.calls }
      end
    end
  end

  private

  def collection
    super.decorate.page(params[:cold_lists_page])
  end

  def permitted_params
    params.permit cold_list: [:notes, :phone_number_prefix, :responsible_id,
      calls_attributes: [:id, :status, :notes, :_destroy,
        phone_number_attributes: [:id, :number, :kind]
      ]
    ]
  end
end
