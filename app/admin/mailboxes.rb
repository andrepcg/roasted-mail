# frozen_string_literal: true

ActiveAdmin.register Mailbox do
  permit_params :email, :token, :expires_at

  # controller do
  #   def find_resource
  #     scoped_collection.find_by(email: params[:id])
  #   end
  # end

  before_filter do
    Mailbox.class_eval do
      def to_param
        id.to_s
      end
    end
  end
end
