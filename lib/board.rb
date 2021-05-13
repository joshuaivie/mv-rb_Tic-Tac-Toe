require_relative './cell'

class Board
  attr_reader :grid, :positions_array, :max_width, :max_height, :board_size

  def initialize(max_width = 3, max_height = 3)
    @max_width = max_width <= 3 ? max_width : 3
    @max_height = max_height <= 3 ? max_height : 3
    @board_size = max_height * max_width
    @positions_array = create_positions
    @grid = build_grid
  end

<<<<<<< HEAD
  def set_value(x, y, value)
    @grid[x][y].write_value(value)
  end

  def get_value(x, y)
    @grid[x][y].value
  end

  def get_position(x, y)
    @grid[x][y].position
  end

  def value_changed?(x, y)
    @grid[x][y].changed
=======
  def set_value(width, height, value)
    @grid[height][width].write_value(value)
  end

  def get_value(width, height)
    @grid[width][height].value
  end

  def get_position(width, height)
    @grid[height][width].position
>>>>>>> b9db16f4ff1e5f421ba8ff830046692c2c56ed16
  end

  def draw_board
    row_iterator = 0
    column_divider = "#{'+---' * @max_width}+"
    board = []

    @max_height.times do
      board.push("#{column_divider}\n")

      row = []
      column_iterator = 0
      @max_width.times do
        value = get_value(row_iterator, column_iterator)
        cell_text = column_iterator == (@max_width - 1) ? "| #{value} |" : "| #{value} "
        row.push(cell_text)
        column_iterator += 1
      end

      result_string = row.join
      board.push("#{result_string}\n")
      row_iterator += 1
    end
    board.push("#{column_divider}\n")
    board
  end

  def available_positions
    available_positions_array = []

    row_iterator = 0
    @max_height.times do
      column_iterator = 0
      @max_width.times do
        if value_changed?(row_iterator, column_iterator) == false
          position = get_position(row_iterator, column_iterator)
          available_positions_array << position
        end
        column_iterator += 1
      end
      row_iterator += 1
    end

    available_positions_array
  end

  private

  def create_positions
    result_array = []
    (1..@board_size).each do |item|
      result_array << item
    end
    result_array
  end

  def build_grid
    grid = []
    positions_array_iterator = 0

    @max_height.times do
      row = []
      column_iterator = 0

      @max_width.times do
        position = @positions_array[positions_array_iterator]
        row[column_iterator] = Cell.new(position)
        column_iterator += 1
        positions_array_iterator += 1
      end

      grid << row
    end

    grid
  end
end

<<<<<<< HEAD
# board = Board.new(3, 3)
# board.set_value(1, 2, 'X')
# puts board.available_positions
=======
board = Board.new
puts board.draw_board
>>>>>>> b9db16f4ff1e5f421ba8ff830046692c2c56ed16
