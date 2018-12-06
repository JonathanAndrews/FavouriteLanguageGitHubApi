# frozen_string_literal: true

require 'user_interface'
require 'git_hub_api_interface'

describe "Feature Tests" do
  describe UserInterface do
    let(:response_array) {
      [
        { 'language' => 'Ruby'},
        { 'language' => 'Ruby'},
        { 'language' => 'Python'},
        { 'language' => 'Elixir'}
      ]
    }
    let(:get_response) { double :GET_Response, body: 'response body' }
    let(:httparty_double) { double :HTTParty, get: get_response }
    let(:json_double) { double :JSON, parse: response_array }
    let(:api_interface) do
      GitHubApiInterface.new(httparty: httparty_double,
                            json: json_double)
    end
    let(:repos_processor) { ReposProcessor.new }
    let(:user_interface) do
      described_class.new(api_interface, repos_processor)
    end

    context 'correct usage of software' do
      describe '#run_program' do
        it "returns 'Ruby'" do
        expect(user_interface.run_program('octocat')).to eq('Ruby')
        end
      end
    end
  end
end