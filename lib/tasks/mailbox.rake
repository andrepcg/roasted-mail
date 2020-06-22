# frozen_string_literal: true

namespace :mailbox do
  desc 'Removes expired mailboxes'
  task remove_expired: :environment do
    Mailbox.expired.destroy_all
  end
end
