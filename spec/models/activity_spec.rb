require 'spec_helper'

describe Activity do
  let(:instance) { FactoryGirl.create(:activity) }

  describe 'callbacks' do
    describe 'on completition' do
      it 'set #completed_date' do
        instance.status = :completed
        date = Time.now
        Time.stub(now: date)
      end
    end
  end
end
