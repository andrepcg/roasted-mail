# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Mailbox::EmailsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :validate_mailbox
  before_action :set_email, only: %i[show destroy render_email_html]

  def index
    @pagy, @emails = pagy(current_mailbox.inbound_emails, link_extra: 'data-remote="true"')
    respond_to do |format|
      format.js
    end
  end

  def show
    @email.update(read_at: Time.zone.now)
    Log.create(action: :open_email)
    respond_to do |format|
      format.js
    end
  end

  def render_email_html
    render html: simple_format(@email.html)
  end

  def destroy
    Log.create(action: :delete_email)
    @email.destroy
  end

  private

  def set_email
    @email = InboundEmail.find_by!(id: params[:email_id], mailbox_id: current_mailbox.id)
  end
end
# rubocop:enable Style/ClassAndModuleChildren
