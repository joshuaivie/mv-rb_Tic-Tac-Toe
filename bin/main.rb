#!/usr/bin/env ruby
begin
  module GameText
    WELCOME_MESSAGE = "Welcome to Boaz and Joshua's Tic Tac Toe Game"
    INSTRUCTIONS = ['The game is played on a 3 by 3 sqaure grid by two players',
                    'At the start of the game players select thier position as X (Player 1) or O (Player 2)',
                    'Players take turns putting their marks in empty squares by inputting a number corresponding to the square in which they want to play',
                    'The first player to get 3 marks in a row (up, down, across, or diagonally) is the winner',
                    'When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.']
    EXIT_MESSAGE = ['Thank you for playing our game', 'Have a great day!']
    INTERRUPT_MESSAGE = ["\nWe're sorry to see you go.\nExiting..."]
  end

  module GameUtils
    def clear_screen
      system('clear') || system('cls')
    end

    def word_wrap(words, indent = 0)
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

    if user_input.to_i == 1
      true
    elsif user_input.to_i == 2
      false
    else
      clear_screen
      puts 'Invalid Input!'
      start_game?
    end
  end

  # at_exit do
  #   include GameUtils
  #   GameUtils.clear_screen
  #   GameText::EXIT_MESSAGE.each do |message|
  #     puts message
  #     sleep(2)
  #     GameUtils.clear_screen
  #   end
  # end

  class BoardCell
    attr_reader :position, :value

    def initialize(position = 0, value = nil)
      @position = position
      @value = value.nil? ? position : value
      @value_changed = false
    end

    def write_value(value)
      if @value_changed == false && %w[X O].include?(value)
        @value = value
        @value_changed = true
        'sucess'
      elsif @value_changed
        'value already changed'
      else
        'must be X or O'
      end
    end
  end

  class Board
    attr_reader :grid, :positions_array

    def initialize(max_width = 3, max_height = 3)
      @max_width = max_width <= 3 ? max_width : 3
      @max_height = max_height <= 3 ? max_height : 3
      @board_size = max_height * max_width
      @positions_array = create_positions
      @grid = build_grid
    end
  end

  def luanch_game
    include GameUtils

    clear_screen
    print_welcome_message
    print_game_instructions
    if start_game?
      puts 'Start Game'
    else
      exit
    end
  end

  # luanch_game
rescue Interrupt
  system('stty -echoctl')
  puts GameText::INTERRUPT_MESSAGE
  sleep(2)
  exit
end
