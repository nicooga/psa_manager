class ProductsController < ApplicationController
  permit_params :name, :bonificable_points, :list_price,
    :suggested_price, :expiration_time, :service_period
end
