require 'spec_helper'

describe SaleArrangement do
  let(:sa) { FactoryGirl.create(:sale_arrangement) }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        sa.update! status: :failed
        sa.next_activity.should be_kind_of(SaleArrangement)
        sa.next_activity.should have_attributes(
          contact_id: sa.contact.id,
          user_id:    sa.user.id,
          address_id: sa.address.id
        )
      end

      it 'on completition' do
        sa.update! status: :completed
        sa.next_activity.should be_kind_of(Sale)
        sa.next_activity.should have_attributes(
          contact_id: sa.contact.id,
          user_id:    sa.user.id,
          address_id: sa.address.id
        )
      end
    end
  end
end
