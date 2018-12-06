# frozen_string_literal: true

require 'git_hub_api_interface'

# UserInterface takes user input and outputs result
class UserInterface
  attr_reader :api_interface

  def initialize(api_interface = GitHubApiInterface.new)
    @api_interface = api_interface
  end

  def run_program(username)
    api_interface.get_repos(username)
  end
end
