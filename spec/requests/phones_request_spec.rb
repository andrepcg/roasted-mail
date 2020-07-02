# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Phones', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/phones/index'
      expect(response).to have_http_status(:success)
    end
  end
end
