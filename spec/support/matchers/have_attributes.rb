RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
    expected.map do |k,v|
      actual.send(k) == v
    end.all?
  end
end
