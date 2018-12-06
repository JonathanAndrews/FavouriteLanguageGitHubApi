# frozen_string_literal: true

require 'user_interface'
require 'git_hub_api_interface'

describe UserInterface do
  let(:response_array) do
    [
      { 'language' => 'Ruby' },
      { 'language' => 'Ruby' },
      { 'language' => 'Python' },
      { 'language' => 'Elixir' }
    ]
  end
  let(:api_interface) { double :GitHubApiInterface, get_repos: response_array }
  let(:repos_processor) { double :ReposProcessor, favourite_lang: 'Ruby' }

  describe '#initialze' do
    it 'calls #favourite_language which calls #get_repos on api_interface' do
      expect(api_interface).to receive(:get_repos)
        .with('octocat')
      described_class.new('octocat', api_interface, repos_processor)
    end
    it 'calls #favourite_language,
        which calls ReposProcessor#favourite_lang on repos_processor' do
      expect(repos_processor).to receive(:favourite_lang)
        .with(response_array)
      described_class.new('octocat', api_interface, repos_processor)
    end
    it 'outputs desired string to stdout' do
      expect do
        described_class.new('octocat', api_interface, repos_processor)
      end
        .to output("octocat's favourite language is Ruby.\n")
        .to_stdout
    end
  end
end
