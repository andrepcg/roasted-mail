# frozen_string_literal: true

class SessionsController < ApplicationController
  def destroy
    destroy_session
    redirect_to root_url
  end
end
