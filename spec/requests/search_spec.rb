require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let(:api_key) { create(:api_key) }
  let(:headers) do
     { 'HTTP_AUTHORIZATION' => "Alexandria-Token api_key=#{api_key.id}:#{api_key.key}" }
  end

  let(:ruby_microscope) { create(:ruby_microscope) }
  let(:rails_tutorial) { create(:ruby_on_rails_tutorial) }
  let(:agile_web_dev) { create(:agile_web_development) }
  let(:books) { [ ruby_microscope, rails_tutorial, agile_web_dev ] }

  let(:json_body) { JSON.parse(response.body) }

  describe 'GET /api/search/:text' do
    before do
      books
    end

    context 'with text = ruby' do
      before { get '/api/search/ruby', headers: headers }

      it 'gets HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'receives a "ruby_microscope" document' do
        expect(json_body['data'][0]['searchable_id']).to eq ruby_microscope.id
        expect(json_body['data'][0]['searchable_type']).to eq 'Book'
      end

      it 'receives a "rails_tutorial" document' do
        expect(json_body['data'][1]['searchable_id']).to eq rails_tutorial.id
        expect(json_body['data'][1]['searchable_type']).to eq 'Book'
      end

      it 'receives a "sam ruby" document' do
        expect(json_body['data'][2]['searchable_id']).to eq agile_web_dev.author.id
        expect(json_body['data'][2]['searchable_type']).to eq 'Author'
      end
    end
  end
end
