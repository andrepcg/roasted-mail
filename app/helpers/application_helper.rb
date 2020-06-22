# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def mailbox_session_url(mailbox)
    mailbox_login_url(mailbox, mailbox.token)
  end
end
