class Society < ActiveRecord::Base
  belongs_to :founder, class_name: User
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  accepts_nested_attributes_for :memberships,
    allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
end
