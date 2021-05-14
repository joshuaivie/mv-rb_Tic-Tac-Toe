require_relative './modules/gameutils'
require_relative './player'
require_relative './board'

class Game
  include GameUtils
  attr_reader :player_one, :player_two, :active_player, :max_moves, :moves_made

  def initialize(players = %w[Josh Boaz])
    @player_one = Player.new(players[0], 'X')
    @player_two = Player.new(players[1], 'O')
  end

  def start_game
    @board = Board.new
    puts @board.draw_board
    width = @board.max_width
    height = @board.max_height
    max_moves = width * height
    game_flow(max_moves)
  end

  def game_flow(max_moves)
    moves_made = 0

    while moves_made < max_moves

    end
  end

  def game
    game_set
    board.display
    turn_controller
    conclusion
  end

  def turn_controller
    if @turn == @player_one.name
      collect_move(one)
      @turn == @player_two.name
    else
      collect_move(two)
      @turn == @player_one.name
    end
    @active_player = @player_one
    @board = Board.new
    @max_moves = @board.board_size
    @moves_made = 0
  end

  def draw_board
    @board.draw_board
  end

  def switch_active_player
    @active_player = if @active_player.name == @player_one.name
                       @player_two
                     else
                       @player_one
                     end
  end

  def solicit_move
    message = "\n\nIt's #{@active_player.name}'s turn to make a move. Enter one of the numbers below to make your move."
    "#{message}\n#{available_positions.join(',')}"
  end

  def warn_invalid_move
    "\nOops! It looks like that is an invalid move, #{@active_player.name}. Try again!"
  end

  def available_positions
    @board.available_positions.sort
  end

  def register_player_move(move)
    @board.set_value(move, @active_player.symbol)
    coordinate = @board.map_position_to_coordinate(move)
    @active_player.make_move(coordinate)
    @moves_made += 1
  end

  def game_end
    win_or_draw = rand(2)
    winner = rand(2)

    if win_or_draw == 1
      if winner == 1
        "Congratulations #{@player_one.name}, you won this round!"
      else
        "Congratulations #{@player_two.name}, you won this round!"\
      end
    else
      "It's a tie!\n\nGood game"
    end
  end
end
