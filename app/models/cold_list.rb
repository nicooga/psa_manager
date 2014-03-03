class ColdList < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: 'User'
  has_many :calls, dependent: :destroy
end
