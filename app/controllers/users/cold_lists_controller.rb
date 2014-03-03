class Users::ColdListsController < InheritedResources::Base
  belongs_to :user

  private

  def permitted_params
    params.permit cold_list: [:notes, :phone_number_prefix]
  end
end
