require 'spec_helper'

describe Service do
  let(:service) { FactoryGirl.create :service }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        service.update! status: :failed
        service.next_activity.should be_kind_of(ServiceArrangement)
        service.next_activity.should have_attributes(
          contact_id:      service.contact.id,
          user_id:         service.user.id,
          address_id:      service.address.id,
          installation_id: service.installation.id
        )
      end

      it 'on completition' do
        service.update! status: :completed

        if service.installation.warranty_about_to_expire?
          service.next_activity.should be_kind_of(ExchangeArrangement)
          service.next_activity.should have_attributes(
            contact_id:      service.contact.id,
            user_id:         service.user.id,
            address_id:      service.address.id,
            installation_id: service.installation.id,
            target_date:     service.installation.warranty_expiration_date - 1.week
          )
        else
          service.next_activity.should be_kind_of(ServiceArrangement)
          service.next_activity.should have_attributes(
            contact_id:      service.contact.id,
            user_id:         service.user.id,
            address_id:      service.address.id,
            installation_id: service.installation.id,
            target_date:     service.installation.warranty_expiration_date - 1.week
          )
        end
      end
    end
  end
end
