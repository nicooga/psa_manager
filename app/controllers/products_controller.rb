class ProductsController < InheritedResources::Base
  private

  def collection() super.decorate end
  def resource() super.decorate end

  def permitted_params
    params.permit product: [:name, :bonificable_points, :list_price,
    :suggested_price, :expiration_time, :service_period]
  end
end
