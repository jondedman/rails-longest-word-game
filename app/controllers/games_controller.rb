# frozen_string_literal: true

require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @word_array = @word.split('')
    @letters = params[:letters].split
    @result = valid_letters?(@word_array, @letters)
    # raise
  end

  def valid_letters?(_word_array, _letters)
    word_set = Set.new(@word_array)
    letter_set = Set.new(@letters)
    if word_set.subset?(letter_set)
      is_a_word?
    else
      "Sorry but '#{@word}' cannot be built out of #{@letters}. Please try again"
    end
  end

  # def is_word_in_grid

  # !@word_array.to_set.subset?(@letters.to_set) ? "You have used letters not in the grid" : "you may proceed to the next check"

  # end

  # def compare
  #   @fail_extra_letters = "You have failed because you have chosen letters not in the original grid"
  #   @word_array.each { |x|
  #     if @letters.include?(x)
  #       i = @letters.find_index(x)
  #       @letters.delete_at(i)
  #     else

  #       return @fail_extra_letters
  #     end
  #   }
  # end
  # end

  # !@word_array.to_set.subset?(@letters.to_set) ? "You have used letters not in the grid" : "you may proceed to the next check"
  # is a refactored way to check with an explanation below

  # "@word_array.to_set" converts the "@word_array" array into a set, which is a collection of unique elements. It means it will remove any duplicate elements in "@word_array"

  # ".subset?" is a method that checks if the set on the left side of the method is a subset of the set on the right side of the method. In this case, it checks if the "@word_array" set is a subset of the "@letters" set. It means it will check whether all elements of "@word_array" set are present in the "@letters" set.

  # "!@word_array.to_set.subset?(@word_array.to_set)" negate the value of subset? so if it's true means attempt_arry is not in g@word_arrayand if false means attempt_arry is in @letters. It means if the elements of "@word_array" are not found in "@word_array then this will return true otherwise false.

  # Then it assigns the result of this check (either true or false) to the variable "word_is_not_in_grid".

  # So, in summary, this code is checking if the elements in "@word_array" are found in "@letters" and store the result in "word_is_not_in_grid" variable, where true means the word is not in grid, and false means the word is in grid.
  # It's like checking if all the letters of a word are present in a grid of letters or not.

  # This refactored version:

  # Introduces a function valid_letters? which takes in two arguments word_array and letters
  # Instead of converting the array to set inside the ternary operator, we are storing it in separate variable for readability
  # The ternary operator is replaced with an if-else block which makes the code more readable.
  # This refactored version makes it clear what the code is doing, and it also makes it easier to test and maintain the code.

  def is_a_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(url).read
    valid = JSON.parse(dictionary)
    if valid['found'] === true
      "congratulations your word '#{@word}' is valid and you score #{valid['length'] * 10} points!"
    else
      "Sorry your word '#{@word}' is not in the dictionary. Please try again"
    end
  end
end
