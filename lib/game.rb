require_relative './player'
require_relative './board'

class Game
  attr_reader :player_one, :player_two

  def initialize(players = %w[Josh Boaz])
    @player_one = Player.new(players[0], 'X')
    @player_two = Player.new(players[1], 'O')
    @board = Board.new
  end

  def start_game
    draw_board
    max_moves = @board.board_size
    moves_made = 0

    while moves_made < max_moves
      collect_player_move
      moves_made += 1
    end
  end

  private

  def draw_board
    puts @board.draw_board
  end

  def collect_player_move
    if @turn == @player_one.name
      collect_move(@player_one)
      @turn == @player_two.name
    else
      collect_move(@player_two)
      @turn == @player_one.name
    end
  end
end
