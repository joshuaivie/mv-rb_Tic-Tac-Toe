require_relative './modules/gameutils'
require_relative './player'
require_relative './board'

class Game
  include GameUtils
  attr_reader :player_one, :player_two

  def initialize(players = %w[Josh Boaz])
    @player_one = Player.new(players[0], 'X')
    @player_two = Player.new(players[1], 'O')
    @active_player = @player_one
    @board = Board.new
  end

  def start_game
    max_moves = @board.board_size
    moves_made = 0

    while moves_made < max_moves
      clear_screen
      draw_board
      collect_player_move
      moves_made += 1
    end
  end

  def draw_board
    puts @board.draw_board
  end

  def collect_player_move
    if @active_player.name == @player_one.name
      collect_move(player_one)
      @active_player = @player_two
    else
      collect_move(player_two)
      @active_player = @player_one
    end
  end

  def collect_move(player)
    puts "\n\nIt's #{player.name}'s turn to make a move.
    Enter one of the numbers below to make your move. \n#{available_positions.join(',')}"
    move = gets.chomp
    if available_positions.any?(move.to_i)
      register_player_move(move.to_i)
    else
      puts "\nOops! It looks like that is an invalid move, #{player.name}. Try again!"
      sleep(2)
      print "\r#{"\e[A" * 6}\e[J"
      collect_move(player)
    end
  end

  def available_positions
    @board.available_positions.sort
  end

  def register_player_move(move)
    @board.set_value(move, @active_player.symbol)
    coordinate = @board.map_position_to_coordinate(move)
    @active_player.make_move(coordinate)
  end
end
