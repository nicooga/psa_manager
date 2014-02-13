require 'spec_helper'

describe DemoArrangement do
  let(:user) do
    User.create!(email: Faker::Internet.email)
  end

  let(:contact) do
    Contact.create!(
      first_name: firstname = Faker::Name.first_name,
      last_name:  lastname = Faker::Name.last_name,
      birthday:  Date.today - 20.years,
      email:     Faker::Internet.email([firstname, lastname].join('_')),
      addresses: [Address.new(
        state:         Address::STATES.sample,
        city:          Faker::Address.city,
        street:        Faker::Address.street_name,
        number:        rand(1..5000),
        zip_code:      Faker::Address.zip_code,
      )]
    )
  end

  let(:da) do
    described_class.new(
      user:    user,
      contact: contact,
      address: contact.addresses.first
    ).tap { |a| a.save(validate: false) }
  end

  describe '#next_activities' do
    describe 'should generate proper activities' do
      it 'on failure' do
        da.status = :failed
        da.save!(validate: false)
        da.next_activities.first.should have_attributes(
          contact_id: da.contact.id,
          user_id:    da.user.id,
          address_id: da.address.id
        )
      end

      it 'on completition' do
        da.status = :completed
        da.save!(validate: false)
        da.next_activities.first.should have_attributes(
          contact_id: da.contact.id,
          user_id:    da.user.id,
          address_id: da.address.id
        )
      end
    end
  end
end
