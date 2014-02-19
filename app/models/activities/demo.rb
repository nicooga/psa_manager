class Demo < Activity
  def next_activity
    case status
    when :completed
      {
        one_of: [Sale, SaleArrangement].map do |a|
          a.new(
            contact_id: self.contact_id,
            user_id:    self.user_id,
            address_id: self.address_id
          )
        end
      }
    when :failed
      DemoArrangement.new(
        contact_id: self.contact_id,
        user_id:    self.user_id,
        address_id: self.address_id
      )
    end
  end
end
