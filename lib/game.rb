require_relative './player'
require_relative './board'

class Game
  attr_reader :player_one, :player_two

  def initialize(players = %w[Josh Boaz])
    @player_one = Player.new(players[0], 'X')
    @player_two = Player.new(players[1], 'O')
  end

  def startGame
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

  def turn_controller
    if @turn == @player_one.name
      collect_move(one)
      @turn == @player_two.name
    else
      collect_move(two)
      @turn == @player_one.name
    end
  end
end
