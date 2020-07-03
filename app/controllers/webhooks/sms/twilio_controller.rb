# frozen_string_literal: true

module Webhooks
  module Sms
    class TwilioController < WebhooksController
      include TwilioRequestValidator

      def inbound_sms
        adapter = SmsAdapters::TwilioAdapter.new(params)
        SmsService::Create.new(adapter).call
        head :ok
      end
    end
  end
end
