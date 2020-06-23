# frozen_string_literal: true

namespace :mailbox do
  desc 'Removes expired mailboxes'
  task remove_expired: :environment do
    Rails.logger.info("Destroying #{Mailbox.expired.count} expired mailboxes")
    Mailbox.expired.destroy_all
  end
end
