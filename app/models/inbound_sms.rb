# frozen_string_literal: true

class InboundSms < ApplicationRecord
  EXPIRES_AFTER = 2.hours
  attr_accessor :to

  has_many_attached :files

  belongs_to :phone_number
  validates :from, :body, :phone_number, :received_at, presence: true

  scope :expired, -> { where('created_at <= ?', Time.zone.now - EXPIRES_AFTER) }
end
