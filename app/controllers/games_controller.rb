require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) {('A'..'Z').to_a.sample}
  end

  def score
    @word = params[:word].upcase
    url = "https://dictionary.lewagon.com/#{@word}"
    @response = URI.parse(url).read
    @letters = params[:letters].chars
    @included = included?(@word, @letters)
    @valid_word = valid_word?(@word)

    if @included && @valid_word
      @message = "Congratulations! #{@word} is a valid English word!"
      @score = @word.length
    elsif @included
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
      @score = 0
    else
      @message = "Sorry but #{@word} can't be built out of #{@letters.join(', ')}"
      @score = 0
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  private
  def valid_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    @response = URI.parse(url).read
    @response['found']
  end
end
