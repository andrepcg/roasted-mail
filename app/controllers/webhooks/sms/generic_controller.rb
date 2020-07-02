# frozen_string_literal: true

module Webhooks
  module Sms
    class GenericController < WebhooksController
      include TaskerRequestValidator

      def inbound_sms
        adapter = ::SmsAdapters::GenericAdapter.new(params)
        Sms::Create.new(adapter).call
        head :ok
      rescue ActiveRecord::RecordNotFound
        head :bad_request
      rescue ActiveRecord::RecordInvalid
        head :bad_request
      end
    end
  end
end
