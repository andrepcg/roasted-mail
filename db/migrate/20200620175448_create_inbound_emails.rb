# frozen_string_literal: true

class CreateInboundEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :inbound_emails do |t|
      t.references :mailbox, null: false, foreign_key: true
      t.text :text
      t.text :html
      t.string :from
      t.string :name
      t.string :sender_ip
      t.string :subject
      t.text :headers
      t.datetime :read_at
      t.timestamps
    end

    add_index :inbound_emails, :created_at
  end
end
