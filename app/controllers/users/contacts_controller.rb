class Users::ContactsController < ApplicationController
  respond_to :html, :json

  def show
    @activities = ActivityDecorator.decorate_collection(
      resource.activities
      .page(params[:activities_page]).per(10)
    )
    @installations = resource.installations
      .page(params[:installation_page]).per(10)
      .decorate
    super
  end

  def show_responder(format)
    format.json do
      render json: resource,
        methods: params[:scope].try(:[], :methods),
        only:    params[:scope].try(:[], :only),
        except:  params[:scope].try(:[], :except)
    end
    format.js { render "contacts/show/show.js.erb", layout: false }
  end

  permit_params :first_name, :last_name, :email, :birthday, :notes, :source_id, :source_date,
    phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy],
    addresses_attributes: [:id, :city, :state, :street, :number, :apartment, :zip_code, :notes, :_destroy,
      phone_numbers_attributes: [:number, :kind, :contact_id, :id, :_destroy]]
end