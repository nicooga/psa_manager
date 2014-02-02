class KitsController < BaseController
  belongs_to :current_user
  permit_params :serial_number, :expiration_time, :aquisition_date, :product_id
end
