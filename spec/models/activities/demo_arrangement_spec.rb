require 'spec_helper'

describe DemoArrangement do
  let(:da) do
    described_class.new.tap { |a| a.save(validate: false) }
  end

  describe '#next_activities' do
    describe 'should generate proper activities' do
      it 'on failure' do
        da.status = :failed
        da.save!(validate: false)
        da.next_activities.first.should have_same_attributes_as(
          DemoArrangement.new(contact: da.contact, user: da.user)
        )
      end

      it 'on completition' do
        da.status = :completed
        da.save!(validate: false)
        da.next_activities.first.should have_same_attributes_as(
          Demo.new(contact: da.contact, user: da.user)
        )
      end
    end
  end
end
