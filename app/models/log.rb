# frozen_string_literal: true

class Log < ApplicationRecord
  enum action: { receive_email: 0, generate_mailbox: 1, open_email: 2, destroy_mailbox: 3, delete_email: 4 }
  validates :action, presence: true

  class << self
    def email_stats
      Rails.cache.fetch('email_stats', expires_in: 5.minutes) do
        Log.receive_email.size
      end
    end

    def mailbox_stats
      Rails.cache.fetch('mailbox_stats', expires_in: 5.minutes) do
        Log.generate_mailbox.size
      end
    end
  end
end
