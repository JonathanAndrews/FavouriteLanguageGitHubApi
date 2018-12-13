require 'mixlib/shellout'
require_relative '../whats_their_favourite_langauge.rb'

describe 'Running the program from the command line' do
  it 'should nothing printed if no arguments' do
    fav_lang = Mixlib::ShellOut.new("ruby whats_their_favourite_langauge.rb")
    fav_lang.run_command
    expect(fav_lang.exitstatus).to eq 0
  end

  it 'should print single fav_lang with single argument' do
    fav_lang = Mixlib::ShellOut.new("ruby whats_their_favourite_langauge.rb octocat")
    fav_lang.run_command
    expect(fav_lang.stdout).to eq "octocat's favourite language is Ruby.\n"
  end
end