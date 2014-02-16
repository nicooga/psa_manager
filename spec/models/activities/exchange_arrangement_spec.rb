require 'spec_helper'

describe ExchangeArrangement do
  let(:ea) { FactoryGirl.create :exchange_arrangement }
  let(:i)  { FactoryGirl.build :installation }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        ea.update! status: :failed
        ea.next_activity.should be_kind_of(ExchangeArrangement)
        ea.next_activity.should have_attributes(
          contact_id:      ea.contact.id,
          user_id:         ea.user.id,
          address_id:      ea.address.id,
          installation_id: ea.installation.id
        )
      end

      it 'on completition' do
        ea.update! status: :completed
        ea.next_activity.should be_kind_of(Exchange)
        ea.next_activity.should have_attributes(
          contact_id:      ea.contact.id,
          user_id:         ea.user.id,
          address_id:      ea.address.id,
          installation_id: ea.installation.id
        )
      end
    end
  end
end
