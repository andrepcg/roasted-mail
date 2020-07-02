# frozen_string_literal: true

module MailboxService
  class TokenValidator
    def self.call(mailbox, token)
      ActiveSupport::SecurityUtils.secure_compare(mailbox.token, token)
    end
  end
end
