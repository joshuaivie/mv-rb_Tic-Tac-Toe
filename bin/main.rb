#!/usr/bin/env ruby
require_relative '../lib/modules/gametext'
require_relative '../lib/modules/gameutils'

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

  at_exit do
    include GameUtils
    GameUtils.clear_screen
    GameText::EXIT_MESSAGE.each do |message|
      puts message
      sleep(2)
      GameUtils.clear_screen
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
