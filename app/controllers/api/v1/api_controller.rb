# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include Pagy::Backend

      before_action :force_json
      before_action :make_action_controller_use_request_host_and_protocol

      rescue_from ActiveRecord::RecordNotFound,
                  with: :rescue_not_found
      def rescue_not_found(_errors)
        head 404
      end

      def force_json
        head :not_acceptable unless request.format.json?
      end

      def validate_mailbox_token
        params[:token] = request.headers['HTTP_X_TOKEN']
        head 401 if params[:token].blank?
      end

      def default_url_options
        { protocol: request.protocol, host: request.host_with_port }
      end

      private

      def make_action_controller_use_request_host_and_protocol
        ActionController::Base.default_url_options[:protocol] = request.protocol
        ActionController::Base.default_url_options[:host] = request.host_with_port
        ActionController::API.default_url_options[:protocol] = request.protocol
        ActionController::API.default_url_options[:host] = request.host_with_port
      end
    end
  end
end
