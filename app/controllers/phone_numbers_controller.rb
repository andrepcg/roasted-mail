# frozen_string_literal: true

class PhoneNumbersController < ApplicationController
  before_action :set_phone_number, only: %i[show]

  def index
    @phones = PhoneNumber.active
    country = params[:country_code]
    @phones = @phones.where(country_iso3166: country) if country
  end

  def show
    @pagy, @sms = pagy @phone.inbound_sms.order(received_at: :desc)
  end

  private

  def set_phone_number
    @phone = PhoneNumber.find_by!(number: "+#{params[:number]}")
  end
end
