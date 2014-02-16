require 'spec_helper'

describe ServiceArrangement do
  let(:sa)           { FactoryGirl.create :service_arrangement }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        sa.update! status: :failed
        sa.next_activity.should be_kind_of(ServiceArrangement)
        sa.next_activity.should have_attributes(
          contact_id:      sa.contact.id,
          user_id:         sa.user.id,
          address_id:      sa.address.id,
          installation_id: sa.installation.id
        )
      end

      it 'on completition' do
        sa.update! status: :completed
        sa.next_activity.should be_kind_of(Service)
        sa.next_activity.should have_attributes(
          contact_id:      sa.contact.id,
          user_id:         sa.user.id,
          address_id:      sa.address.id,
          installation_id: sa.installation.id,
          target_date:     sa.installation.next_service_date - 1.week
        )
      end
    end
  end
end
