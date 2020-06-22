# frozen_string_literal: true

class CreateMailboxes < ActiveRecord::Migration[6.0]
  def change
    create_table :mailboxes do |t|
      t.string :email, index: { unique: true }
      t.string :token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
