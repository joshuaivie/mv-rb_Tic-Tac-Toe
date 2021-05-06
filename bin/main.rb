#!/usr/bin/env ruby

module GameText
  WELCOME_MESSAGE = "Welcome to Boaz and Joshua's Tic Tac Toe Game"
  INSTRUCTIONS = ['The game is played on a 3 by 3 sqaure grid by two players',
                  'At the start of the game players select thier position as X (Player 1) or O (Player 2)',
                  'Players take turns putting their marks in empty squares by inputting a number corresponding to the square in which they want to play',
                  'The first player to get 3 marks in a row (up, down, across, or diagonally) is the winner',
                  'When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.']
end

module GameUtils
  def self.clear_screen
    system('clear') || system('cls')
  end
end

def print_welcome_message
  puts GameText::WELCOME_MESSAGE
end

def print_game_instructions
  sleep(0.5)
  puts "\nGAME INSTRUCTIONS"
  GameText::INSTRUCTIONS.each_with_index do |instruction, index|
    puts "#{index + 1} - #{instruction}"
    sleep(2)
  end
end

def luanch_game
  GameUtils.clear_screen
  print_welcome_message
  print_game_instructions
end

luanch_game

terminal_width = `tput cols`.to_i
puts terminal_width
