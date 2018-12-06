# frozen_string_literal: true

require 'httparty'
require 'json'

# ApiInterface fetchs Github repos while protecting against edge cases.
class ApiInterface
  attr_reader :httparty, :json

  def initialize(httparty: HTTParty, json: JSON)
    @httparty = httparty
    @json = json
  end

  def get_repos(username)
    url = "https://api.github.com/users/#{username}/repos"
    response = httparty.get(url)
    json.parse(response.body)
  end
end
