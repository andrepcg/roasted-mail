Fabricator(:mailbox) do
  email      { Faker::Internet.email }
  token      { Faker::Internet.password(min_length: 10, max_length: 20) }
  inbound_emails(count: 5)
end