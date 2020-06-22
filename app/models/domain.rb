# frozen_string_literal: true

class Domain < ApplicationRecord
  validates :domain, presence: true

  def url
    "https://#{domain}"
  end
end
