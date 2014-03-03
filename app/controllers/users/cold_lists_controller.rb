class Users::ColdListsController < InheritedResources::Base
  belongs_to :user

  has_scope(:assigned, type: :boolean) do |controller, scope|
    controller.send(:parent).assigned_cold_lists
  end

  def index
    index! do |format|
      format.js { render 'index.js.erb', layout: false }
    end
  end

  private

  def collection
    super.decorate.page(params[:cold_lists_page])
  end

  def permitted_params
    params.permit cold_list: [:notes, :phone_number_prefix, :responsible_id]
  end
end
