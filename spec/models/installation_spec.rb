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
end
