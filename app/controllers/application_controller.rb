# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception
  before_action :make_action_controller_use_request_host_and_protocol

  def validate_mailbox
    return true if current_mailbox

    destroy_session
    redirect_to root_path
  end

  def create_session(mailbox)
    session[:mailbox_id] = mailbox.id
    session[:mailbox_token] = mailbox.token
  end

  def destroy_session
    # session.delete(:mailbox_id)
    # session.delete(:mailbox_token)
    reset_session
    @current_mailbox = nil
  end

  def current_mailbox
    @current_mailbox ||=
      session[:mailbox_id] &&
      session[:mailbox_token] &&
      Mailbox.find_by(id: session[:mailbox_id], token: session[:mailbox_token])
  end
  helper_method :current_mailbox

  private

  def make_action_controller_use_request_host_and_protocol
    ActionController::Base.default_url_options[:protocol] = request.protocol
    ActionController::Base.default_url_options[:host] = request.host_with_port
  end
end
