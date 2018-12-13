require 'mixlib/shellout'
require_relative '../whats_their_favourite_langauge.rb'

describe 'Running the program from the command line' do
  it 'should nothing printed if no arguments' do
    fav_lang = Mixlib::ShellOut.new("ruby whats_their_favourite_langauge.rb")
    fav_lang.run_command
    expect(fav_lang.exitstatus).to eq 0
  end
end