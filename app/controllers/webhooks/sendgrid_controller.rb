# frozen_string_literal: true

module Webhooks
  class SendgridController < WebhooksController
    before_action :validate_sendgrid_request

    def inbound
      EmailReceiver.new(params).call
    rescue StandardError
      head :ok
    ensure
      head :ok
    end

    private

    def validate_sendgrid_request
      valid_ip = SendgridRequestValidator.call request.remote_ip

      head :unauthorized unless valid_ip
    end
  end
end
