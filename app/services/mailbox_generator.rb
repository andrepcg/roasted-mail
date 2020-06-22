# frozen_string_literal: true

class MailboxGenerator
  def self.call
    username = AnimalCodes.sample
    domain = Domain.order(Arel.sql('RANDOM()')).first
    email = "#{username}@#{domain.domain}"
    Mailbox.create(email: email)
  end
end
