class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :kits, dependent: :destroy
  has_many :activities

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@]+@[^@]+\..+\z/ }

  def self.fetch(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) ||
    create_with_auth_hash(auth)
  end

  def self.create_with_auth_hash(auth)
    create!(
      provider: auth['provider'],
      uid:      auth['uid'],
      email:    auth['info']['email']
    )
  end
end
