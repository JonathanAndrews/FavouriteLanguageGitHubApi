# frozen_string_literal: true

require_relative 'git_hub_api_interface'
require_relative 'repos_processor'

# UserInterface takes user input and outputs result
class UserInterface
  attr_reader :api_interface, :processor

  def initialize(username,
                 api_interface = GitHubApiInterface.new,
                 processor = ReposProcessor.new)
    @api_interface = api_interface
    @processor = processor
    favourite_language(username)
  end

  private

  def favourite_language(username)
    repos = api_interface.get_repos(username)
    language = processor.favourite_lang(repos)
    output_string(username, language)
  end

  def output_string(username, language)
    puts "#{username}'s favourite language is #{language}."
  end
end
