# frozen_string_literal: true

class StatsProducer
  class << self
    def call
      Rails.cache.fetch('stats', expires_in: 5.minutes) do
        { emails_count: email_stats, mailboxes_count: mailbox_stats, sms_count: sms_stats }
      end
    end

    def email_stats
      Log.receive_email.size
    end

    def mailbox_stats
      Log.generate_mailbox.size
    end

    def sms_stats
      Log.receive_sms.size
    end
  end
end
