class Users::ColdListsController < InheritedResources::Base
  belongs_to :user

  private

  def permitted_params
    params.permit cold_list: [:notes, :phone_number_prefix,
      calls_attributes: [:phone_number_id, :notes, :status, :id, :_destroy,
        phone_number_attributes: [:number, :kind]]]
  end
end
