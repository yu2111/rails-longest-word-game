require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    letters = params[:letters].split(' ')
    answer = params[:answer]
    valid_answer = answer.upcase.chars.all? { |char| letters.include?(char) }
    url = "https://dictionary.lewagon.com/#{answer}"
    response = JSON.parse(URI.open(url).read)
    valid = response['found']
    @result =
      if valid && valid_answer
        "Congrats #{answer.upcase} is a valid word!"
      elsif valid && valid_answer == false
        "Sorry, #{answer.upcase} can't be build with #{letters.join(', ')}"
      else
        "Sorry, #{answer.upcase} isn't a valid word.."
      end
  end
end
