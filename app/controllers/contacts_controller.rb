class ContactsController < BaseController
  respond_to :html, :json
  belongs_to :current_user

  def show_responder(format)
    format.json do
      render json: resource,
        methods: params[:scope].try(:[], :methods),
        only:    params[:scope].try(:[], :only),
        except:  params[:scope].try(:[], :except)
    end
  end

  permit_params :first_name, :last_name, :email, :birthday, :notes,
    addresses_attributes: [:id, :city, :state, :street, :number, :apartment, :zip_code, :notes, :_destroy,
      phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]],
    phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]
end
