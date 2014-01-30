class Contact < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name, :email, :birthday, presence: true
  validates :email, format: { with: /\A[^@]+@[^@]+\..+\z/ }
end
