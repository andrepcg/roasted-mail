# frozen_string_literal: true

Fabricator(:inbound_email) do
  # mailbox
  text       { Faker::Lorem.paragraphs(number: 4).join }
  from       { Faker::Internet.email }
  name       { Faker::Name.name }
  sender_ip  { Faker::Internet.ip_v4_address }
  subject    { Faker::Lorem.sentence }
end
