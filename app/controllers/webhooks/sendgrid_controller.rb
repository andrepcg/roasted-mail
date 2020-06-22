# frozen_string_literal: true

module Webhooks
  class SendgridController < WebhooksController
    def inbound
      EmailReceiver.new(params).call
    rescue StandardError
      head :ok
    ensure
      head :ok
    end
  end
end
