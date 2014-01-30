class User < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@]+@[^@]+\..+\z/ }

  def self.fetch_by_auth_hash(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) ||
    create_with_auth_hash(auth)
  end

  def self.create_with_auth_hash(auth)
    create!(
      provider: auth['provider'],
      uid:      auth['uid'],
      email:    auth['info']['email'],
      name:     auth['info']['name'],
    )
  end
end
