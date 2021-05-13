require_relative './modules/gameutils'
require_relative './player'
require_relative './board'

class Game
  include GameUtils
  attr_reader :player_one, :player_two

  def initialize(players = %w[Josh Boaz])
    @player_one = Player.new(players[0], 'X')
    @player_two = Player.new(players[1], 'O')
<<<<<<< HEAD
    @active_player = @player_one
    @board = Board.new
=======
  end

  def start_game
    @board = Board.new
    puts @board.draw_board

    width = @board.max_width
    height = @board.max_height
    max_moves = width * height
    game_flow(max_moves)
>>>>>>> b9db16f4ff1e5f421ba8ff830046692c2c56ed16
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
    puts "\n\nIt's #{player.name}'s turn to make a move. Enter one of the numbers below to make your move. \n#{available_positions.join(',')}"
    move = gets.chomp
    if available_positions.any?(move.to_i)
      move
    else
      puts "\nOops! It looks like that is an invalid move, #{player.name}. Try again!"
      sleep(2)
      print "\r#{"\e[A" * 7}\e[J"
      collect_move(player)
    end
  end

  def available_positions
    @board.available_positions.sort
  end
end

game = Game.new
game.start_game
