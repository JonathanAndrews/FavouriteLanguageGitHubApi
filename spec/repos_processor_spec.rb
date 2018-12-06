# frozen_string_literal: true

require 'repos_processor'

describe ReposProcessor do
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
  let(:processor) { described_class.new }

  describe '#favourite_lang' do
    it 'extract the languages from the repos_array' do
      expect(processor.favourite_lang(repos_array)).to eq(
        'Ruby' => 3, 'Python' => 1, 'Elixir' => 1
      )
    end
  end
end
