# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  def validate_mailbox
    redirect_to root_path unless current_mailbox
  end

  def create_session(mailbox)
    session[:mailbox_id] = mailbox.id
    session[:mailbox_token] = mailbox.token
  end

  def destroy_session
    session.delete(:mailbox_id)
    session.delete(:mailbox_token)
    @current_mailbox = nil
  end

  def current_mailbox
    @current_mailbox ||=
      session[:mailbox_id] &&
      session[:mailbox_token] &&
      Mailbox.find_by(id: session[:mailbox_id], token: session[:mailbox_token])
  end
  helper_method :current_mailbox
end
