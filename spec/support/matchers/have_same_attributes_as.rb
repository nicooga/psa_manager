RSpec::Matchers.define :have_same_attributes_as do |expected|
  match do |actual|
    ignored = [:id, :updated_at, :created_at]
    actual.attributes.except(*ignored) == expected.attributes.except(*ignored)
  end
end
