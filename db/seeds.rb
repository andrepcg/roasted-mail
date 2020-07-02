# frozen_string_literal: true

domains = %w[roasted.email ihave.buzz needemail.top iamno.monster].map do |n|
  { domain: n }
end

Domain.create(domains)

10.times do
  mailbox = MailboxService::Generator.call
  20.times do
    InboundEmail.create mailbox: mailbox,
                        from: Faker::Internet.email,
                        name: Faker::Name.name,
                        subject: Faker::Lorem.sentence(word_count: 3),
                        text: Faker::Lorem.paragraphs(number: 4).join('\n'),
                        sender_ip: Faker::Internet.ip_v4_address
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?