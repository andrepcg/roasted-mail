# frozen_string_literal: true

module TaskerRequestValidator
  extend ActiveSupport::Concern

  included do
    before_action :validate_request
  end

  def validate_request
    return head :bad_request if missing_token?

    valid = ActiveSupport::SecurityUtils.secure_compare(token, ENV['SMS_POST_TOKEN'])

    head :bad_request unless valid
  end

  def missing_token?
    token.blank?
  end

  def token
    request.headers['X-Tasker-Token']
  end
end
