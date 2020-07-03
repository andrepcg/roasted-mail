# frozen_string_literal: true

namespace :sms do
  task remove_expired: :environment do
    Rails.logger.info("Destroying #{InboundSms.expired.count} expired SMSes")
    InboundSms.expired.destroy_all
  end
end
