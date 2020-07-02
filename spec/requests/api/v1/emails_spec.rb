# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/emails', type: :request do
  path '/api/v1/mailbox/{mailbox_id}/emails' do
    parameter name: 'mailbox_id', in: :path, type: :integer, description: 'mailbox_id'
    parameter name: 'page', in: :query, type: :string, description: 'Page number'
    let(:page) { 1 }

    get 'Retrieves emails from a mailbox' do
      tags 'Emails'
      security [Token: []]
      consumes 'application/json'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/mailbox_emails'

        let(:mailbox) { Fabricate :mailbox }
        let(:mailbox_id) { mailbox.id }
        let('X-TOKEN') { mailbox.token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['emails']).to be_an_instance_of(Array)
          expect(data['pagy']).to be_an_instance_of(Hash)
        end
      end

      response 401, 'authentication failed' do
        let(:mailbox) { MailboxService::Generator.call }
        let(:mailbox_id) { mailbox.id }
        let('X-TOKEN') { 'tokenXYZ' }
        run_test!
      end
    end
  end

  path '/api/v1/mailbox/{mailbox_id}/emails/{id}' do
    parameter name: 'mailbox_id', in: :path, type: :integer, description: 'mailbox_id'
    parameter name: 'id', in: :path, type: :integer, description: 'email id'

    get 'shows email full details' do
      tags 'Emails'
      security [Token: []]
      consumes 'application/json'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/mailbox_emails'

        let(:mailbox) { Fabricate :mailbox }
        let(:mailbox_id) { mailbox.id }
        let(:id) { mailbox.inbound_emails.first.id }
        let('X-TOKEN') { mailbox.token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
        end
      end

      response 401, 'authentication failed' do
        let(:mailbox) { Fabricate :mailbox }
        let(:mailbox_id) { mailbox.id }
        let(:id) { mailbox.inbound_emails.first.id }
        let('X-TOKEN') { 'tokenXYZ' }
        run_test!
      end
    end

    delete 'deletes an email' do
      tags 'Emails'
      security [Token: []]
      consumes 'application/json'
      produces 'application/json'

      response 204, 'successful' do
        let(:mailbox) { Fabricate :mailbox }
        let(:mailbox_id) { mailbox.id }
        let(:id) { mailbox.inbound_emails.first.id }
        let('X-TOKEN') { mailbox.token }

        run_test!
      end

      response 401, 'authentication failed' do
        let(:mailbox) { Fabricate :mailbox }
        let(:mailbox_id) { mailbox.id }
        let(:id) { mailbox.inbound_emails.first.id }
        let('X-TOKEN') { 'tokenXYZ' }
        run_test!
      end
    end
  end
end
