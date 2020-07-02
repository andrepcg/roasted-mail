# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Webhooks::Sms::GenericController, type: :request do
  describe 'POST /inbound_sms' do
    before do
      ENV['TASKER_TOKEN'] = 'valid'
    end

    let(:phone) { Fabricate :phone_number }

    it 'returns http bad_request with invalid token' do
      post '/webhooks/sms/generic', headers: { 'X-Tasker-Token': 'invalid' }
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns http ok when valid' do
      post '/webhooks/sms/generic', headers: { 'X-Tasker-Token': 'valid' },
                                    params: {
                                      from: '+351123456',
                                      from_name: 'Jonas',
                                      timestamp: '1593539312',
                                      body: 'Wow this is greatá!',
                                      to: phone.number
                                    }
      expect(response).to have_http_status(:ok)
      expect(InboundSms.last.from).to eq('+351123456')
    end

    it 'fails when phone number is not on the system' do
      post '/webhooks/sms/generic', headers: { 'X-Tasker-Token': 'valid' },
                                    params: {
                                      from: '+351123456',
                                      from_name: 'Jonas',
                                      timestamp: '1593539312',
                                      body: 'Wow this is greatá!',
                                      to: '+3510000000'
                                    }
      expect(response).to have_http_status(:bad_request)
    end

    it 'fails when necessary params are not passed' do
      expect do
        post '/webhooks/sms/generic', headers: { 'X-Tasker-Token': 'valid' },
                                      params: {
                                        from_name: 'Jonas',
                                        timestamp: '1593539312',
                                        body: 'Wow this is greatá!',
                                        to: phone.number
                                      }
      end.to_not change(InboundSms, :count)
      expect(response).to have_http_status(:bad_request)
    end
  end
end
