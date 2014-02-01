class ContactsController < BaseController
  belongs_to :current_user

  permit_params :first_name, :last_name, :email, :birthday, :notes,
    addresses_attributes: [:id, :city, :state, :street, :number, :apartment, :zip_code, :notes, :_destroy,
      phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]],
    phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]
end
