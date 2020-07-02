# frozen_string_literal: true

module PhonesHelper
  def flag_url(phone_number)
    "https://cdn.staticaly.com/gh/hjnilsson/country-flags/master/svg/#{phone_number.country_iso3166.downcase}.svg"
  end
end
