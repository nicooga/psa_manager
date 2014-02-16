class Installation < ActiveRecord::Base
  belongs_to :kit
  belongs_to :contact
  belongs_to :address
  belongs_to :user

  validates :address, :contact, :kit, presence: true

  def next_service_date
    now = Time.now
    service_period = kit.product.service_period.months
    tsls = (now - date.to_time.to_i).to_i % service_period
    (now + service_period - tsls).to_date
  end
end
