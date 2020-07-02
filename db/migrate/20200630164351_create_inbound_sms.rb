class CreateInboundSms < ActiveRecord::Migration[6.0]
  def change
    create_table :inbound_sms do |t|
      t.string :from
      t.string :from_name
      t.datetime :received_at
      t.text :body
      t.references :phone_number, foreign_key: true


      t.timestamps
    end
  end
end
