# frozen_string_literal: true

class PhoneNumber < ApplicationRecord
  has_many :inbound_sms, class_name: 'InboundSms', dependent: :destroy
  validates :number, :country_iso3166, presence: true

  attribute :available, :boolean, default: -> { true }
  scope :active, -> { where(available: true) }

  def country_name
    ISO3166::Country.new(country_iso3166).name
  end

  def display_name
    number
  end

  def to_param
    number[1..-1]
  end
end
