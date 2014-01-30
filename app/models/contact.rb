class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :addresses, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank

  validates :first_name, :last_name, :email, :birthday, presence: true
  validates :email, format: { with: /\A[^@]+@[^@]+\..+\z/ }
end
