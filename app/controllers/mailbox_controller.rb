# frozen_string_literal: true

class MailboxController < ApplicationController
  before_action :validate_mailbox, only: %i[inbox]
  before_action :redirect_to_mailbox, only: %i[index]

  def index; end

  def inbox; end

  def create
    mailbox = MailboxGenerator.call
    create_session mailbox
    redirect_to mailbox_path
  end

  def login
    mailbox = Mailbox.find_by(email: params['email'], token: params['token'])

    create_session mailbox if mailbox
    redirect_to mailbox_path
  end

  def logout
    destroy_session
    redirect_to root_url
  end

  def destroy
    current_mailbox.destroy
    destroy_session
    redirect_to root_url
  end

  private

  def redirect_to_mailbox
    return redirect_to mailbox_inbox_path if current_mailbox
  end
end
