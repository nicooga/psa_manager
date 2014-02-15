require 'spec_helper'

describe Activity do
  let(:instance) do
    described_class.new.tap { |a| a.save(validate: false) }
  end

  describe 'callbacks' do
    describe 'on completition' do
      it 'set #completed_date' do
        instance.status = :completed
        date = Time.now
        Time.stub(now: date)
        instance.stub :valid? => true
        instance.save!(validate: false)
        instance.completed_date.should eq(date)
      end

      it 'triggers #generate_next_activity' do
        instance.should_receive(:generate_next_activity).once
        instance.status = :completed
        instance.save(validate: false)
      end
    end

    it 'on failure triggers #reschedule' do
      instance.should_receive(:reschedule).once
      instance.status = :failed
      instance.save!(validate: false)
    end
  end
end
