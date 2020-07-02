# frozen_string_literal: true

class Changelog < ApplicationRecord
  validates :title, :text, :slug, presence: true

  def title=(value)
    super(value)
    self.slug = value&.parameterize
  end
end
