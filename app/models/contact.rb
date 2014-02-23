class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :source, class_name: 'Contact'

  has_many :addresses, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :activities
  has_many :installations

  accepts_nested_attributes_for :addresses, :phone_numbers,
    allow_destroy: true, reject_if: :all_blank

  validates :first_name, :last_name, :email, :birthday, presence: true
  validates :email, format: { with: /\A[^@]+@[^@]+\..+\z/ }

  scope :with_activities_pending, -> { joins(:activities).where activities: { status: :pending } }
end
