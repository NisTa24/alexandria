require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:api_key) { create(:api_key) }

  describe 'Client Authentication' do
    context 'with invalid authentication scheme' do
      let(:headers) { { 'HTTP_AUTHORIZATION' => '' } }

      before { get '/api/books', headers: headers }

      it 'gets HTTP status 401 Unauthorized' do
        expect(response.status).to eq 401
      end
    end

    context 'with valid authentication scheme' do
      let(:headers) { { "HTTP_AUTHORIZATION" => "Alexandria-Token api_key=#{api_key.id}:#{key}" } }

      before { get '/api/books', headers: headers }

      context 'with invalid API key' do
        let(:key) { 'InvalidKey' }

        it 'gets HTTP status 401 Unauthorized' do
          expect(response.status).to eq 401
        end
      end

      context 'with disabled API Key' do
        let(:key) { api_key.key }
        let(:headers) { { "HTTP_AUTHORIZATION" => "Alexandria-Token api_key=#{api_key.id}:#{key}" } }

        before do
          api_key.disable

          get '/api/books', headers: headers
        end

        it 'gets HTTP status 401 Unauthorized' do
          expect(response.status).to eq 401
        end
      end

      context 'with valid API Key' do
        let(:key) { api_key.key }

        it 'gets HTTP status 200' do
          expect(response.status).to eq 200
        end
      end
    end
  end
end
