class Users::SocietiesController < InheritedResources::Base
  belongs_to :user
  respond_to :html

  private

  def collection() super.decorate end
  def resource() super.decorate end

  def permitted_params
    params.permit society: [:name, :description,
      memberships_attributes: [:id, :_destroy, :user_id]]
  end
end
