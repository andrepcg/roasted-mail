# frozen_string_literal: true

ActiveAdmin.register Mailbox do
  permit_params :email, :token, :expires_at

  before_filter do
    Mailbox.class_eval do
      def to_param
        id.to_s
      end
    end
  end
end
