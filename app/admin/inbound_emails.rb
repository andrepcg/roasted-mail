# frozen_string_literal: true

ActiveAdmin.register InboundEmail do
  permit_params :mailbox_id, :text, :html, :from, :name, :sender_ip, :subject, :headers, :read_at
end
