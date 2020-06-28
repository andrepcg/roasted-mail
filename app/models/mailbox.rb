# frozen_string_literal: true

class Mailbox < ApplicationRecord
  DEFAULT_VALID_FOR = 7.days

  has_secure_token
  has_many :inbound_emails, dependent: :destroy
  validates :email, presence: true

  attribute :expires_at, :datetime, default: -> { Time.zone.now + DEFAULT_VALID_FOR }

  scope :expired, -> { where('expires_at <= ?', Time.zone.now) }

  after_destroy :log

  def self.create_custom(username, domain_id)
    domain = Domain.find domain_id
    email = "#{username}@#{domain.domain}"
    create(email: email)
  end

  def to_param
    email
  end

  private

  def log
    Log.create(action: :destroy_mailbox)
  end
end
