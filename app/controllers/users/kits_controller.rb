class Users::KitsController < ApplicationController
  permit_params :serial_number, :acquisition_date, :product_id
end
