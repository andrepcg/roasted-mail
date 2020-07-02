# frozen_string_literal: true

Fabricator(:inbound_sms) do
  from            { Faker::PhoneNumber.phone_number_with_country_code }
  from_name       { Faker::Name.first_name }
  received_at     { Faker::Date.between(from: 7.days.ago, to: DateTime.now) }
  body            { Faker::Lorem.sentence }
  phone_number
end
