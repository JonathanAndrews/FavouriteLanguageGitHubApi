# frozen_string_literal: true

# ReposProcessor contains methods that extract data from an Array of Hashes
class ReposProcessor
  def favourite_lang(repos_array)
    languages_array = []
    repos_array.each { |json| languages_array.push(json['language']) }
    languages_array
  end
end
