# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/mailbox', type: :request do
  path '/api/v1/mailbox' do
    post 'creates a mailbox' do
      tags 'Mailbox'
      consumes 'application/json'
      produces 'application/json'
      description 'Generates a random mailbox. API method is capped at 15 requests every 24 seconds' \
                  '(or 1 request every 1.6 seconds)'

      response 201, 'mailbox created' do
        schema '$ref' => '#/components/schemas/mailbox'
        run_test!
      end

      response 429, 'too many requests' do
        header 'RateLimit-Limit', type: :integer,
                                  description: 'The number of allowed requests in the current period'
        header 'Rate-Limit-Remaining', type: :integer,
                                       description: 'The number of remaining requests in the current period'
        header 'Rate-Limit-Reset', type: :integer, description: 'The unix timestamp when the limit resets'
        run_test!
      end
    end
  end

  path '/api/v1/mailbox/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get 'Retrieves a mailbox' do
      tags 'Mailbox'
      security [Token: []]
      consumes 'application/json'
      produces 'application/json'

      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/mailbox'

        let(:mailbox) { Fabricate :mailbox }
        let(:id) { mailbox.id }
        let('X-TOKEN') { mailbox.token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['email']).to eq(mailbox.email)
        end
      end

      response 401, 'authentication failed' do
        let(:mailbox) { Fabricate :mailbox }
        let(:id) { mailbox.id }
        let('X-TOKEN') { 'tokenXYZ' }
        run_test!
      end
    end

    delete 'deletes mailbox' do
      tags 'Mailbox'
      security [Token: []]
      consumes 'application/json'
      produces 'application/json'

      response 204, 'successful' do
        let(:mailbox) { Fabricate :mailbox }
        let(:id) { mailbox.id }
        let('X-TOKEN') { mailbox.token }

        run_test!
      end

      response 401, 'authentication failed' do
        let(:mailbox) { Fabricate :mailbox }
        let(:id) { mailbox.id }
        let('X-TOKEN') { 'tokenXYZ' }
        run_test!
      end
    end
  end
end
