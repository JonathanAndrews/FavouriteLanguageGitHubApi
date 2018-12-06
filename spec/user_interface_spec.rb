# frozen_string_literal: true

require 'user_interface'
require 'git_hub_api_interface'

describe UserInterface do
  let(:api_interface) { double :GitHubApiInterface }
  let(:user_interface) do
    described_class.new(api_interface)
  end

  context 'correct usage of software' do
    describe '#run_program' do
      it 'returns response array' do
        expect(api_interface).to receive(:get_repos)
          .with('octocat')
        user_interface.run_program('octocat')
      end
    end
  end
end
