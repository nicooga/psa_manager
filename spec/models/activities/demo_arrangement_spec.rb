require 'spec_helper'

describe DemoArrangement do
  let(:da) { FactoryGirl.create(:demo_arrangement) }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        da.update! status: :failed
        da.next_activity.should have_attributes(
          contact_id: da.contact.id,
          user_id:    da.user.id,
          address_id: da.address.id
        )
      end

      it 'on completition' do
        da.update! status: :completed
        da.next_activity.should have_attributes(
          contact_id: da.contact.id,
          user_id:    da.user.id,
          address_id: da.address.id
        )
      end
    end
  end
end
