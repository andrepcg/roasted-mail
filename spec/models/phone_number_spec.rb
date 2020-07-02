# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  let(:phone) { Fabricate :phone_number }

  it 'is valid with valid attributes' do
    expect(InboundSms.new(phone_number: phone,
                          from: '+3519898',
                          body: 'Hi there mate',
                          received_at: DateTime.now)).to be_valid
  end

  it 'is not valid without sender' do
    expect(InboundSms.new(phone_number: phone,
                          body: 'Hi there mate',
                          received_at: DateTime.now)).to be_invalid
  end

  it 'is not valid without body' do
    expect(InboundSms.new(phone_number: phone,
                          from: '+3519898',
                          received_at: DateTime.now)).to be_invalid
  end

  it 'is not valid without phone_number (to)' do
    expect(InboundSms.new(from: '+3519898',
                          body: 'Hi there mate',
                          received_at: DateTime.now)).to be_invalid
  end
end
