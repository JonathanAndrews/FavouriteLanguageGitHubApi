# frozen_string_literal: true

require_relative 'lib/user_interface'

ARGV.each { |github_name| UserInterface.new(github_name) }
