# frozen_string_literal: true

Fabricator(:phone_number) do
  number    { Faker::PhoneNumber.cell_phone_in_e164 }
  available true
end
