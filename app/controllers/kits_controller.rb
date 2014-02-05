class KitsController < BaseController
  belongs_to :current_user
  permit_params :serial_number, :acquisition_date, :product_id
end
