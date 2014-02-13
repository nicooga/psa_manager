require 'spec_helper'

describe Demo do
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

  let(:demo) do
    described_class.new(
      user:    user,
      contact: contact,
      address: contact.addresses.first,
    ).tap { |a| a.save(validate: false) }
  end

  describe '#next_activities' do
    describe 'should generate proper activities' do
      it 'on failure' do
        demo.status = :failed
        demo.save!(validate: false)
        demo.next_activities.first.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )
      end

      it 'on completition' do
        demo.status = :completed
        demo.save!(validate: false)
        demo.next_activities.should be_has_key(:one_of)

        demo.next_activities[:one_of].first.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )

        demo.next_activities[:one_of].second.should have_attributes(
          contact_id: demo.contact.id,
          user_id:    demo.user.id,
          address_id: demo.address.id
        )
      end
    end
  end
end
