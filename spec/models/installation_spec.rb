require 'spec_helper'

describe Installation do
  let(:i) { FactoryGirl.create(:installation) }

  describe 'validations' do
    it 'require a contact' do
      i.contact = nil
      i.should_not be_valid
    end

    it 'require an address' do
      i.address = nil
      i.should_not be_valid
    end

    it 'require a kit' do
      i.kit = nil
      i.should_not be_valid
    end
  end

  describe '#next_service_date' do
    it 'retrieves next service date' do
      now = freeze_time
      service_period = i.kit.product.service_period.months
      installation_date = i.date
      tsls = (now - installation_date.to_time.to_i).to_i % service_period
      next_service_date = (now + service_period - tsls).to_date

      i.next_service_date.should eq(next_service_date)
    end
  end
end
