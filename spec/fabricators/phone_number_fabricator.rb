# frozen_string_literal: true

Fabricator(:phone_number) do
  number    { Faker::PhoneNumber.cell_phone_in_e164 }
  available true
  country_iso3166 { Faker::Address.country_code }
end
