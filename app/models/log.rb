# frozen_string_literal: true

class Log < ApplicationRecord
  enum action: { receive_email: 0, generate_mailbox: 1, open_email: 2, destroy_mailbox: 3, delete_email: 4 }
  validates :action, presence: true
end
