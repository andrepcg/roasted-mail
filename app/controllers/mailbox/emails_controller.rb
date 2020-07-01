# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Mailbox::EmailsController < ApplicationController
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::JavaScriptHelper

  ALLOWED_TAGS = %w(html style strong em b i p code pre tt samp kbd var sub
    sup dfn cite big small address hr br div span h1 h2 h3 h4 h5 h6 ul ol li dl dt dd abbr
    acronym a img blockquote del ins).freeze
  ALLOWED_ATTRIBUTES = %w(href src width id class style height alt cite datetime title class name xml:lang abbr).freeze

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
    render html: sanitize(@email.html.html_safe, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES)
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
