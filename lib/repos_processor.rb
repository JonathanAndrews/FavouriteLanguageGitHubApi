# frozen_string_literal: true

# ReposProcessor contains methods that extract data from an Array of Hashes
class ReposProcessor
  def favourite_lang(repos_array)
    language_array = extract_languages(repos_array)
    language_hash_with_nil = count_languages(language_array)
    language_hash = remove_nil(language_hash_with_nil)
  end

  private

  def extract_languages(repos_array)
    languages_array = []
    repos_array.each { |json| languages_array.push(json['language']) }
    languages_array
  end

  def count_languages(array)
    languages_hash = Hash.new(0)
    array.each { |language| languages_hash[language] += 1 }
    languages_hash
  end

  def remove_nil(hash)
    hash.delete(nil)
    hash
  end
end
