class ColdList < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: 'User'
  has_many :calls, dependent: :destroy

  accepts_nested_attributes_for :calls,
    allow_destroy: true, reject_if: :all_blank
end
