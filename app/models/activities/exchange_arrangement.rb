class ExchangeArrangement < Activity
  belongs_to :installation
  validates :installation, presence: true
end
