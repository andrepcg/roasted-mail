# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    mailbox = Mailbox.find_by(email: params['email'], token: params['token'])

    create_session mailbox if mailbox
    redirect_to mailbox_path
  end

  def destroy
    destroy_session
    redirect_to root_url
  end
end
