require 'spec_helper'

describe Sale do
  let(:sale) { FactoryGirl.create(:sale) }
  let(:installation) { FactoryGirl.build :installation }

  describe '#next_activity' do
    describe 'should generate proper activities' do
      it 'on failure' do
        sale.update! status: :failed
        sale.next_activity.should be_kind_of(SaleArrangement)
        sale.next_activity.should have_attributes(
          contact_id: sale.contact.id,
          user_id:    sale.user.id,
          address_id: sale.address.id
        )
      end

      describe 'on completition:' do
        it 'requires an installation' do
          expect do
            sale.update!(status: :completed)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'generates a service' do
          sale.update!(
            status: :completed,
            installation_attributes: installation.attributes.except(*%w|id created_at updated_at|)
          )

          sale.next_activity.should be_kind_of(ServiceArrangement)
          sale.next_activity.should have_attributes(
            contact_id:      sale.contact.id,
            user_id:         sale.user.id,
            address_id:      sale.address.id,
            installation_id: sale.installation.id
          )
        end

       it 'generated service should have proper attributes' do
         date = Time.now
         Time.stub now: date
         sale.update!(
           status: :completed,
           installation_attributes: installation.attributes.except(*%w|id created_at updated_at|)
         )
         sale.next_activity.target_date.should eq(
           date + sale.installation.kit.product.service_period.months - 1.week
         )
       end
      end
    end
  end
end
