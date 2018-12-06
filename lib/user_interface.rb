# frozen_string_literal: true

require 'git_hub_api_interface'
require 'repos_processor'

# UserInterface takes user input and outputs result
class UserInterface
  attr_reader :api_interface, :processor

  def initialize(api_interface = GitHubApiInterface.new,
                 processor = ReposProcessor.new)
    @api_interface = api_interface
    @processor = processor
  end

  def run_program(username)
    repos = api_interface.get_repos(username)
    processor.favourite_lang(repos)
  end
end
