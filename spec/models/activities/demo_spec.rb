require 'spec_helper'

describe Demo do
  let(:demo) { FactoryGirl.create(:demo) }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        demo.update! status: :failed
        demo.next_activity.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )
      end

      it 'on completition' do
        demo.update! status: :completed
        demo.next_activity.should be_has_key(:one_of)

        demo.next_activity[:one_of].first.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )

        demo.next_activity[:one_of].second.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )
      end
    end
  end
end
