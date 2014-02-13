class Demo < Activity
  def reschedule
    self.next_activities = [
      DemoArrangement.new(
        contact_id: self.contact_id,
        user_id:    self.user_id,
        address_id: self.address_id
      )
    ]
  end

  def generate_next_activities
    self.next_activities = {
      one_of: [
        SaleArrangement.new(
          contact_id: self.contact_id,
          user_id:    self.user_id,
          address_id: self.address_id
        ),
        Sale.new(
          contact_id: self.contact_id,
          user_id:    self.user_id,
          address_id: self.address_id
        )
      ]
    }
  end
end
