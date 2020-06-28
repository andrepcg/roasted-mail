# frozen_string_literal: true

module Api
  module V1
    class EmailsController < ApiController
      before_action :validate_mailbox_token, only: %i[index show destroy]
      before_action :set_mailbox, only: %i[index show destroy]
      before_action :set_email, only: %i[show destroy]

      def index
        @pagy, @emails = pagy(@mailbox.inbound_emails)
        @pagy_metadata = pagy_metadata(@pagy)
      end

      def show; end

      def destroy
        @email.destroy
      end

      private

      def set_email
        @email = InboundEmail.find_by!(id: params[:id], mailbox: @mailbox)
      end

      def set_mailbox
        @mailbox = Mailbox.find_by!(id: params[:mailbox_id])
        head 401 unless MailboxTokenValidator.call(@mailbox, params[:token])
      end
    end
  end
end
