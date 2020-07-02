# frozen_string_literal: true

module TwilioRequestValidator
  extend ActiveSupport::Concern

  included do
    before_action :validate_request
  end

  def validate_request
    return head :bad_request if missing_signature?

    result = validator.validate(
      request.url,
      request.request_parameters.sort.to_h,
      request.headers['X-Twilio-Signature']
    )

    head :bad_request unless result
  end

  def missing_signature?
    request.headers['X-Twilio-Signature'].blank?
  end

  def validator
    Twilio::Security::RequestValidator.new(ENV['TWILIO_AUTH_TOKEN'])
  end
end
