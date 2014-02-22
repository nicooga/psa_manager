require 'spec_helper'

describe Statusable do
  let(:extended_class) do
    Class.new(Activity) do
      include Statusable
      has_statuses *statuses
    end
  end
  let(:statuses) { [:pending, :completed, :failed] }

  describe '::has_statuses' do
    describe 'defines class methods' do
      it '::<statuses>' do
        extended_class.statuses.sort.should eq(statuses.sort)
      end

      describe 'scopes' do
        before do
          statuses.each do |s|
            10.times do
              FactoryGirl.create extended_class.superclass.model_name.element, status: s
            end
          end
        end

        it '::<status> scope for each status value' do
          statuses.each do |s|
            extended_class.send(s).all? do |r|
              r.status == s
            end.should be_true
          end
        end

        it '::_not_<status> scope for each status value' do
          statuses.each do |s|
            extended_class.send("not_#{s}").all? do |r|
              r.status != s
            end.should be_true
          end
        end
      end
    end

    describe 'defines instance methods' do
      it 'defines #<status>? for each status value' do
        statuses.each do |s|
          instance = extended_class.new(status: s)
          instance.send(:"#{s}?").should be_true
          (statuses - [s]).each do |ns|
            instance.send(:"#{ns}?").should be_false
          end
        end
      end

      it 'defines #not_<status>? for each status value' do
        statuses.each do |s|
          instance = extended_class.new(status: s)
          instance.send(:"not_#{s}?").should be_false
          (statuses - [s]).each do |ns|
            instance.send(:"not_#{ns}?").should be_true
          end
        end
      end
    end
  end
end
