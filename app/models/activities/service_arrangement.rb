class ServiceArrangement < Activity
  belongs_to :installation
  validates :installation, presence: true
end
