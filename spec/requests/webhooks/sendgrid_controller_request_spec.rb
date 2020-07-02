# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Webhooks::SendgridController, type: :request do
  describe 'POST /email_inbound' do
    let!(:mailbox) { Fabricate :mailbox }

    it 'raises error when params are invalid' do
      expect do
        post '/webhooks/email_inbound'
      end.to_not change(InboundEmail, :count)
      expect(response).to have_http_status(:ok)
    end

    it 'creates inbound email' do
      expect do
        post '/webhooks/email_inbound', params: { subject: 'Hi!',
                                                  headers: 'xyz',
                                                  sender_ip: '10.0.0.1',
                                                  to: mailbox.email,
                                                  from: 'me@hey.com' }
      end.to change(InboundEmail, :count)
      expect(response).to have_http_status(:ok)
    end

    it 'fails to create email when mailbox does not exist' do
      expect do
        post '/webhooks/email_inbound', params: { subject: 'Hi!',
                                                  headers: 'xyz',
                                                  sender_ip: '10.0.0.1',
                                                  to: 'invalid@hey.com',
                                                  from: 'me@hey.com' }
      end.to_not change(InboundEmail, :count)
      expect(response).to have_http_status(:ok)
    end

    it 'fails to create email when params are invalid' do
      expect do
        post '/webhooks/email_inbound', params: { headers: 'xyz',
                                                  to: mailbox.email }
      end.to_not change(InboundEmail, :count)
      expect(response).to have_http_status(:ok)
    end

    it 'fails sendgrid ip validation' do
      post '/webhooks/email_inbound', env: { "REMOTE_ADDR": '151.101.193.69' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
