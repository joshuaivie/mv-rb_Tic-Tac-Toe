class Player
<<<<<<< HEAD
  attr_reader :name
  attr_accessor :symbol
=======
  attr_reader :name, :symbol, :moves
>>>>>>> 4cb7dc6945afab47ea7960c8aeaad72e872a2f7b

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
<<<<<<< HEAD
  end
end
=======
    @moves = []
  end

  def make_move(position)
    moves << position
  end
end
>>>>>>> 4cb7dc6945afab47ea7960c8aeaad72e872a2f7b
