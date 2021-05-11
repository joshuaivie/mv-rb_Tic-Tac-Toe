class Player
  attr_reader :name, :symbol, :moves

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @moves = []
  end

  def make_move(position)
    moves << position
  end
end
