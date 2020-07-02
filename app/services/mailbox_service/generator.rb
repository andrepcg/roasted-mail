# frozen_string_literal: true

module MailboxService
  class Generator
    def self.call
      username = AnimalCodes.sample
      domain = Domain.order(Arel.sql('RANDOM()')).first
      email = "#{username}@#{domain.domain}"
      mb = Mailbox.create(email: email)
      Log.create(action: :generate_mailbox)
      mb
    end
  end
end
