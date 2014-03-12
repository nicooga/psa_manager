class Installation < ActiveRecord::Base
  belongs_to :kit
  belongs_to :contact
  belongs_to :address
  belongs_to :user
  has_one :product, through: :kit

  validates :date, :address, :contact, :kit, presence: true

  scope :about_to_expire, -> do
    where %q|"installations"."next_service_date" <= "installations"."warranty_expiration_date"|
  end

  scope :next_service_near, -> do
    where %q|"installations"."next_service_date" <= ?|, Time.now + 2.weeks
  end

  scope :important, -> do
    where [about_to_expire, next_service_near].map(&:where_clauses).join(' OR ')
  end

  after_touch :update_next_service_date
  after_create :update_warranty_expiration_date
  after_create :update_next_service_date

  def warranty_about_to_expire?
    warranty_expiration_date <= next_service_date ||
    warranty_expiration_date <= Time.now
  end

  def date_caches_outdated?
    next_service_date.nil? || next_service_date < Timen.now? ||
    warranty_expiration_date.nil? || warranty_expiration_date < Time.now
  end

  private

  def calculate_next_service_date
    now = Time.now
    service_period = kit.product.service_period.months
    tsls = (now - date.to_time.to_i).to_i % service_period
    (now + service_period - tsls).to_date
  end

  def calculate_warranty_expiration_date
    date.advance months: kit.product.expiration_time
  end

  def update_next_service_date
    update!(next_service_date: calculate_next_service_date)
  end

  def update_warranty_expiration_date
    update(warranty_expiration_date: calculate_warranty_expiration_date)
  end
end
