# frozen_string_literal: true

class MailboxController < ApplicationController
  before_action :validate_mailbox, only: %i[index]

  def index
    return render :index unless current_mailbox

    render :show
  end

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

  def destroy
    @mailbox.destroy
    destroy_session
    redirect_to root_url
  end
end
