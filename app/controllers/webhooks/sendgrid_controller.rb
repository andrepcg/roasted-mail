# frozen_string_literal: true

module Webhooks
  class SendgridController < WebhooksController
    include SendgridRequestValidator

    def inbound
      Email::Receive.new(params).call
      head :ok
    rescue StandardError
      head :ok
    end
  end
end
