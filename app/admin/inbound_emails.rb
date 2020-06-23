# frozen_string_literal: true

ActiveAdmin.register InboundEmail do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :mailbox_id, :text, :html, :from, :name, :sender_ip, :subject, :headers, :read_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:mailbox_id, :text, :html, :from, :name, :sender_ip, :subject, :headers, :read_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
