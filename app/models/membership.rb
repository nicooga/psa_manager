class Membership < ActiveRecord::Base
  belongs_to :society
  belongs_to :user

  validates :user, uniqueness: { scope: :society }
end
