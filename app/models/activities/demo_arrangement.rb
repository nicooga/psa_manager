class DemoArrangement < Activity
  def next_activity
    case status
    when :completed
      Demo.new(
        contact_id: self.contact_id,
        user_id:    self.user_id,
        address_id: self.address_id
      )
    when :failed
      DemoArrangement.new(
        contact_id: self.contact_id,
        user_id:    self.user_id,
        address_id: self.address_id
      )
    end
  end
end
