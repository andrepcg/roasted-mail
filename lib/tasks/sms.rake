namespace :sms do
  task remove_expired: :environment do
    Rails.logger.info("Destroying #{InboundSms.old.count} expired SMSes")
    InboundSms.expired.destroy_all
  end
end
