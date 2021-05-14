#!/usr/bin/env ruby

require_relative '../lib/selection'
require_relative '../lib/player'

begin
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

  board_interface = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def display_board(board_interface)
    puts "+---+---+---+"
    puts "| #{board_interface[0]} | #{board_interface[1]} | #{board_interface[2]} |"
    puts "+---+---+---+"
    puts "| #{board_interface[3]} | #{board_interface[4]} | #{board_interface[5]} |"
    puts "+---+---+---+"
    puts "| #{board_interface[6]} | #{board_interface[7]} | #{board_interface[8]} |"
    puts "+---+---+---+"
  end

  display_board(board_interface)

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

begin
  def print_welcome_message
    include GameText
    puts WELCOME_MESSAGE
  end

  def print_game_instructions
    include GameText
    include GameUtils

    sleep(0.5)
    puts "\nGAME INSTRUCTIONS"
    INSTRUCTIONS.each_with_index do |instruction, index|
      text = "#{index + 1} - #{instruction}"
      puts word_wrap(text, 4)
      sleep(2)
    end
  end

  def start_game?
    include GameUtils

    puts "\nPress 1 to start.     Press 2 to Exit."
    user_input = gets.chomp

    case user_input.to_i
    when 1
      true
    when 2
      false
    else
      clear_screen
      puts 'Invalid Input!'
      start_game?
    end
  end

  def store_name(message)
    include GameUtils
    GameUtils.clear_screen

    puts message
    name = gets.chomp

    if name.nil?
      puts "\nKindly input a valid name/alias"
      store_name
    else
      name
    end
  end

  def print_names(name_one, name_two)
    include GameUtils
    GameUtils.clear_screen
    sleep(1)
    puts "#{name_one} will be 'X' and #{name_two} will be 'O'"
    sleep(2)
    GameUtils.clear_screen
    puts 'BEGIN'
    sleep(2)
  end

  def collect_player_names
    player_one_name = store_name('Please enter the name/alias of player 1')
    player_two_name = store_name('Please enter the name/alias of player 2')
    print_names(player_one_name, player_two_name)
    [player_one_name, player_two_name]
  end

  def collect_player_move(game)
    puts game.solicit_move
    move = gets.chomp

    if game.available_positions.any?(move.to_i)
      move.to_i
    else
      puts game.warn_invalid_move
      sleep(2)
      print "\r#{"\e[A" * 6}\e[J"
      collect_player_move(game)
    end
  end

  def luanch_game
    include GameUtils

    clear_screen
    print_welcome_message
    print_game_instructions
    if start_game?
      player_names = collect_player_names
      current_game = Game.new(player_names)
      while current_game.moves_made < current_game.max_moves
        clear_screen
        puts current_game.draw_board

        move = collect_player_move(current_game)
        current_game.register_player_move(move)
        current_game.switch_active_player
      end
    else
      exit
    end
  end

  at_exit do
    include GameUtils
    GameUtils.clear_screen
    GameText::EXIT_MESSAGE.each do |message|
      puts message
      sleep(2)
      GameUtils.clear_screen
    end
  end

  luanch_game
rescue Interrupt
  system('stty -echoctl')
  puts GameText::INTERRUPT_MESSAGE
  sleep(2)
  exit
end
