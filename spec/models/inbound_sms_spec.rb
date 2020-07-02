# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InboundSms, type: :model do
  let!(:sms) { Fabricate :inbound_sms, created_at: DateTime.now }
  let!(:old_sms) { Fabricate :inbound_sms, created_at: 3.hours.ago }

  it 'finds old sms' do
    expect(InboundSms.expired.to_a).to eq([old_sms])
  end
end
