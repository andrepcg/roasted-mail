module Api
  module V1
    class MailboxController < ApiController
      before_action :validate_mailbox_token, only: %i[show destroy]
      before_action :set_mailbox, only: %i[show destroy]

      def show
        @last_email = @mailbox.inbound_emails&.first
      end

      def create
        @mailbox = MailboxGenerator.call
        render :show
      end

      def destroy
        current_mailbox.destroy
      end

      private

      def set_mailbox
        @mailbox = Mailbox.find_by!(id: params[:id])

        head 401 unless MailboxTokenValidator.call(@mailbox, params[:token])
      end
    end
  end
end