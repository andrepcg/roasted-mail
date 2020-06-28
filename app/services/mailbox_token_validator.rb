# frozen_string_literal: true

class MailboxTokenValidator
  def self.call(mailbox, token)
    ActiveSupport::SecurityUtils.secure_compare(mailbox.token, token)
  end
end
