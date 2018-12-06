# frozen_string_literal: true

require 'user_interface'
require 'git_hub_api_interface'

describe UserInterface do
  let(:get_response) { double :GET_Response, body: 'response body' }
  let(:httparty_double) { double :HTTParty, get: get_response }
  let(:json_double) { double :JSON, parse: ['response array'] }
  let(:api_interface) do
    GitHubApiInterface.new(httparty: httparty_double,
                           json: json_double)
  end
  let(:user_interface) do
    described_class.new(api_interface)
  end

  context 'correct usage of software' do
    describe '#run_program' do
      it 'returns response array' do
        expect(user_interface.run_program('octocat')).to eq(['response array'])
      end
    end
  end
end
