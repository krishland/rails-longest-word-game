require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def letter_in_grid
    @answer.upcase.chars.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if letter_in_grid == false
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif english_word? == false
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid == true && english_word? == false
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else letter_in_grid == true && english_word? == true
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end

end
