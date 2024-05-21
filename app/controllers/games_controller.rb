require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    size = 10
    letters = ('a'..'z').to_a # Array of lowercase and uppercase letters
    @letters = Array.new(size) { letters.sample }
  end

  def score
    word = params[:word]
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    valid = json["found"]
    split_word_array = word.chars
    letters_array = params[:letters].split(" ")

    if valid == true
      split_word_array.each do |letter|
        letters_array.delete_at(letters_array.index(letter)) if letters_array.include?(letter)
      end
      if letters_array.length == (10 - word.length)
        @score = "#{word} is included in the #{params[:letters]} and is valid word"
      else
        @score = "sorry but #{word} cant be built out of #{params[:letters]}"
      end
    else
      @score = "word is not valid"
    end
  end
end
