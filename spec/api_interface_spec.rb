# frozen_string_literal: true

require 'api_interface'

describe ApiInterface do
  let(:get_response) { double :GET_Response, body: 'response body' }
  let(:httparty_double) { double :HTTParty, get: get_response }
  let(:json_double) { double :JSON, parse: ['response array'] }
  let(:interface) do
    described_class.new(httparty: httparty_double,
                        json: json_double)
  end

  describe '#get_repos' do
    it 'HTTParty should receive #get with url' do
      url = 'https://api.github.com/users/octocat/repos'
      expect(httparty_double).to receive(:get).with(url)
      interface.get_repos('octocat')
    end
    it 'JSON should receive #parse with GET request Response' do
      expect(json_double).to receive(:parse).with('response body')
      interface.get_repos('octocat')
    end
    it 'should return api repsonse array ' do
      expect(interface.get_repos('octocat')).to eq(['response array'])
    end
  end
end
