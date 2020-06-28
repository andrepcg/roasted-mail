# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Roasted.email - API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'roasted.email'
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          Token: {
            description: 'Mailbox Token in the header',
            type: :apiKey,
            name: 'X-TOKEN',
            in: :header
          }
        },
        schemas: {
          mailbox: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string },
              token: { type: :string },
              created_at: { type: :string },
              expires_at: { type: :string },
              last_email_id: { type: :integer, nullable: true },
              last_email_received_at: { type: :string, nullable: true }
            }
          },
          email: {
            type: :object,
            properties: {
              id: { type: :integer },
              text: { type: :string },
              html: { type: :string },
              to: { type: :string },
              from: {
                type: :object,
                properties: {
                  name: { type: :string, nullable: true },
                  email: { type: :string }
                }
              },
              subject: { type: :string },
              headers: { type: :string },
              received_at: { type: :string },
              sender_ip: { type: :string },
              attachments: {
                type: :array,
                items: {
                  '$ref' => '#/components/schemas/attachment'
                }
              }
            }
          },
          attachment: {
            type: :object,
            properties: {
              filename: { type: :string },
              url: { type: :string }
            }
          },
          pagination: {
            type: :object,
            properties: {
              count: { type: :integer },
              items: { type: :integer },
              last: { type: :integer },
              next: { type: :integer, nullable: true },
              prev: { type: :integer, nullable: true },
              page: { type: :integer }
            }
          },
          mailbox_emails: {
            type: :object,
            properties: {
              emails: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    text: { type: :string },
                    subject: { type: :string },
                    received_at: { type: :string },
                    from: {
                      type: :object,
                      properties: {
                        name: { type: :string, nullable: true },
                        email: { type: :string }
                      }
                    }
                  }
                }
              },
              pagy: {
                '$ref' => '#/components/schemas/pagination'
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
