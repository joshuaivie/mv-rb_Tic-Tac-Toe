require_relative './cell'

class Board
  attr_reader :grid, :positions_array, :max_width, :max_height

  def initialize(max_width = 3, max_height = 3)
    @max_width = max_width <= 3 ? max_width : 3
    @max_height = max_height <= 3 ? max_height : 3
    @board_size = max_height * max_width
    @positions_array = create_positions
    @grid = build_grid
  end

  def set_value(x, y, value)
    @grid[y][x].write_value(value)
  end

  def get_value(x, y)
    @grid[y][x].value
  end

  def get_position(x, y)
    @grid[y][x].position
  end

  def draw_board
    column_iterator = 0
    column_divider = "#{'+---' * @max_width}+"
    board = []

    @max_height.times do
      board.push("#{column_divider}\n")

      row = []
      row_iterator = 0
      @max_width.times do
        value = get_value(row_iterator, column_iterator)
        cell_text = row_iterator == (@max_width - 1) ? "| #{value} |" : "| #{value} "
        row.push(cell_text)
        row_iterator += 1
      end

      result_string = row.join
      board.push("#{result_string}\n")
      column_iterator += 1
    end
    board.push("#{column_divider}\n")
    board
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
      row_iterator = 0

      @max_width.times do
        position = @positions_array[positions_array_iterator]
        row[row_iterator] = Cell.new(position)
        row_iterator += 1
        positions_array_iterator += 1
      end

      grid << row
    end

    grid
  end
end

board = Board.new()
puts board.draw_board
