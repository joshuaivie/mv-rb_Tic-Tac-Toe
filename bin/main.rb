#!/usr/bin/env ruby

module GameText
  WELCOME_MESSAGE = "Welcome to Boaz and Joshua's Tic Tac Toe Game"
  INSTRUCTIONS = ['The game is played on a 3 by 3 sqaure grid by two players',
                  'At the start of the game players select thier position as X (Player 1) or O (Player 2)',
                  'Players take turns putting their marks in empty squares by inputting a number corresponding to the square in which they want to play',
                  'The first player to get 3 marks in a row (up, down, across, or diagonally) is the winner',
                  'When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.']
  EXIT_MESSAGE = ['Thank you for playing our game', 'Have a good day!']
  INTERRUPT_MESSAGE = ["\nWe're sorry to see you go.\nExiting..."]
end

module GameUtils
  def self.clear_screen
    system('clear') || system('cls')
  end

  def self.word_wrap(words, indent = 0)
    character_array = words.split('')
    new_character_array = []
    reset_counter = 0

    terminal_width = `tput cols`.to_i
    maximum_length = terminal_width - (terminal_width * 0.15)

    character_array.each do |character|
      if character == "\n"
        reset_counter = 0
      elsif reset_counter >= maximum_length && character == ' '
        if indent.positive?
          new_character_array << "\n"
          (0...(indent - 1)).each do |_i|
            new_character_array << ' '
            reset_counter += 1
          end
          reset_counter = 0
        else
          character = "\n"
          reset_counter = 0
        end
      end
      new_character_array << character
      reset_counter += 1
    end

    new_character_array.join.to_s
  end
end

def print_welcome_message
  puts GameText::WELCOME_MESSAGE
end

def print_game_instructions
  sleep(0.5)
  puts "\nGAME INSTRUCTIONS"
  GameText::INSTRUCTIONS.each_with_index do |instruction, index|
    text = "#{index + 1} - #{instruction}"
    puts GameUtils.word_wrap(text, 4)
    sleep(2)
  end
end

def start_game?
  puts "\nPress 1 to start.     Press 2 to Exit."
  user_input = gets.chomp
  if user_input.to_i == 1
    true
  elsif user_input.to_i == 2
    false
  else
    GameUtils.clear_screen
    puts 'Invalid Input!'
    start_game?
  end
end

at_exit do
  GameUtils.clear_screen
  GameText::EXIT_MESSAGE.each do |message|
    puts message
    sleep(2)
    GameUtils.clear_screen
  end
end

trap 'SIGINT' do
  system('stty -echoctl')
  puts GameText::INTERRUPT_MESSAGE
  sleep(2)
  exit
end

def luanch_game
  GameUtils.clear_screen
  print_welcome_message
  print_game_instructions
  if start_game?
    puts 'Start Game'
  else
    exit
  end
end

luanch_game
