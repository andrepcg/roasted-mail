# frozen_string_literal: true

class InboundEmail < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many_attached :files
  belongs_to :mailbox

  validates :from, :mailbox, :sender_ip, presence: true
end
