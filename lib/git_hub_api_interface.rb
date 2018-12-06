# frozen_string_literal: true

require 'httparty'
require 'json'

# ApiInterface fetchs Github repos while protecting against edge cases.
class GitHubApiInterface
  attr_reader :httparty, :json

  def initialize(httparty: HTTParty, json: JSON)
    @httparty = httparty
    @json = json
  end

  def get_repos(username)
    url = "https://api.github.com/users/#{username}/repos"
    response = make_get_request(url)
    repo_array = json.parse(response.body)
    validate_username(repo_array)
    repo_array
  end

  private

  def make_get_request(url)
    httparty.get(url)
  rescue SocketError
    raise 'Are you connected to the Internet?'
  rescue StandardError
    raise 'Unable to make GET request'
  end

  def validate_username(response)
    raise 'Not a valid Github Username' if user_not_found?(response)
  end

  def user_not_found?(response)
    response.is_a?(Hash) && response['message'] == 'Not Found'
  end
end
