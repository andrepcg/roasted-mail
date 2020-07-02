# frozen_string_literal: true

ActiveAdmin.register InboundSms do
  permit_params :from, :from_name, :received_at, :body, :phone_number_id
end
