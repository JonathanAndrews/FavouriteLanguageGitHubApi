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
  let(:user_interface) do
    described_class.new(api_interface, repos_processor)
  end

  describe '#run_program' do
    it 'calls get_repos on api_interface' do
      expect(api_interface).to receive(:get_repos)
        .with('octocat')
      user_interface.run_program('octocat')
    end
    it 'calls favourite_lang on repos_processor' do
      expect(repos_processor).to receive(:favourite_lang)
        .with(response_array)
      user_interface.run_program('octocat')
    end
  end
end
