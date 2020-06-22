# frozen_string_literal: true

module Mailbox
  class EmailsController < ApplicationController
    before_action :validate_mailbox
    before_action :set_email, only: %i[show destroy]

    def index
      @pagy, @emails = pagy(current_mailbox.inbound_emails, link_extra: 'data-remote="true"')
      respond_to do |format|
        format.js
      end
    end

    def show; end

    def destroy
      @email.destroy
    end

    private

    def set_email
      @email = InboundEmail.find_by!(id: params[:email_id], mailbox_id: current_mailbox.id)
    end
  end
end
