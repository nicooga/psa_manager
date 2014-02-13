class Demo < Activity
  def reschedule
    self.next_activities = [DemoArrangement.new(contact: self.contact, user: self.user)]
  end

  def generate_next_activities
    self.next_activities = {
      one_of: [
        SaleArrangement.new(contact: self.contact, user: self.user),
        Sale.new(contact: self.contact, user: self.user)
      ]
    }
  end
end
