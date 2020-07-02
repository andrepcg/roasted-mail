# frozen_string_literal: true

class InboundSms < ApplicationRecord
  attr_accessor :to

  has_many_attached :files

  belongs_to :phone_number
  validates :from, :body, :phone_number, :received_at, presence: true
end
