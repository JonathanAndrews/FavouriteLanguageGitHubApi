# frozen_string_literal: true

require 'user_interface'
require 'git_hub_api_interface'

describe 'Feature Tests' do
  describe UserInterface do
    let(:repos_array) do
      [
        { 'language' => nil },
        { 'language' => nil },
        { 'language' => nil },
        { 'language' => nil },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => 'Ruby' },
        { 'language' => 'Python' },
        { 'language' => 'Elixir' }
      ]
    end
    let(:get_response) { double :GET_Response, body: 'response body' }
    let(:httparty_double) { double :HTTParty, get: get_response }
    let(:json_double) { double :JSON, parse: repos_array }
    let(:api_interface) do
      GitHubApiInterface.new(httparty: httparty_double,
                             json: json_double)
    end
    let(:repos_processor) { ReposProcessor.new }

    describe '#intialize' do
      it "outputs 'octocat's favourite language is Ruby.' to stdout" do
        expect do
          described_class.new('octocat', api_interface, repos_processor)
        end
          .to output("octocat's favourite language is Ruby.\n")
          .to_stdout
      end
    end
  end
end
