require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ("AEIOUY".split("") + ('A'..'Z').to_a).sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = check_letters(@word, @letters)
    @exist = word_exist?(@word)
  end

  def check_letters(word, letters)
    # the method below is checking if a letter |w| from the @word string occours  the same number of times as it does in the @letters array. That is why it iterates over each letter (.count(w))
    word.chars.all? { |w| word.count(w) <= letters.count(w) }
  end

  def word_exist?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
