# frozen_string_literal: true

class Domain < ApplicationRecord
  validates :domain, presence: true
end
