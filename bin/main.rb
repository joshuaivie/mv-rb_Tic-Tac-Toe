#!/usr/bin/env ruby
require_relative '../lib/modules/gametext'
require_relative '../lib/modules/gameutils'
require_relative '../lib/game'

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