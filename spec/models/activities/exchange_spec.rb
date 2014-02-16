require 'spec_helper'

describe Exchange do
  let(:exchange) { FactoryGirl.create :exchange }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        exchange.update! status: :failed
        exchange.next_activity.should be_kind_of(ExchangeArrangement)
        exchange.next_activity.should have_attributes(
          contact_id:      exchange.contact.id,
          user_id:         exchange.user.id,
          address_id:      exchange.address.id,
          installation_id: exchange.installation.id
        )
      end

      it 'on completition' do
        exchange.update! status: :completed
        exchange.next_activity.should be_kind_of(Sale)
        exchange.next_activity.should have_attributes(
          contact_id:      exchange.contact.id,
          user_id:         exchange.user.id,
          address_id:      exchange.address.id,
        )
      end
    end
  end
end
