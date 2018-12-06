# frozen_string_literal: true

require 'git_hub_api_interface'

describe GitHubApiInterface do
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
  let(:interface) do
    described_class.new(httparty: httparty_double,
                        json: json_double)
  end
  context 'correct usage of software' do
    describe '#get_repos' do
      it 'calls #make_get_request with url' do
        url = 'https://api.github.com/users/octocat/repos'
        expect(interface).to receive(:make_get_request)
          .with(url).and_call_original
        interface.get_repos('octocat')
      end
      it 'JSON should receive #parse with GET request Response' do
        expect(json_double).to receive(:parse).with('response body')
        interface.get_repos('octocat')
      end
      it 'calls #validate_username with repo_array' do
        expect(interface).to receive(:validate_username)
          .with([
            { 'language' => 'Ruby'},
            { 'language' => 'Ruby'},
            { 'language' => 'Python'},
            { 'language' => 'Elixir'}
          ])
        interface.get_repos('octocat')
      end
      it 'should return api repsonse array ' do
        expect(interface.get_repos('octocat')).to eq([
          { 'language' => 'Ruby'},
          { 'language' => 'Ruby'},
          { 'language' => 'Python'},
          { 'language' => 'Elixir'}
        ])
      end
    end
  end

  context 'edge-cases' do
    describe 'when disconnected from the internet, #get_repos' do
      it 'throws an Internet error' do
        allow(httparty_double).to receive(:get).and_raise(SocketError)
        expect { interface.get_repos('octocat') }
          .to raise_error(RuntimeError, 'Are you connected to the Internet?')
      end
    end
    describe 'when unable to make request for another reason, #get_repos' do
      it "throws an 'Unable to make GET request' error" do
        allow(httparty_double).to receive(:get).and_raise(StandardError)
        expect { interface.get_repos('octocat') }
          .to raise_error(StandardError, 'Unable to make GET request')
      end
    end
    describe 'when #get_repos is given a fake username ' do
      it "throws an 'Not a valid Github Username' error" do
        allow(json_double).to receive(:parse)
          .and_return('message' => 'Not Found')
        expect { interface.get_repos('NOT_A_USERNAME') }
          .to raise_error(StandardError, 'Not a valid Github Username')
      end
    end
  end
end
