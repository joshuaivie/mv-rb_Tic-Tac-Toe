require_relative './cell'

class Board
  attr_reader :grid, :positions_array, :max_width, :max_height, :board_size

  def initialize
    @max_width = 3
    @max_height = 3
    @board_size = max_height * max_width
    @positions_array = create_positions
    @grid = build_grid
  end

  def set_value(position, value)
    positions = map_position_to_coordinate(position)
    x_coordinate = positions[0]
    y_coordinate = positions[1]
    @grid[x_coordinate][y_coordinate].write_value(value)
  end

  def get_value(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate].value
  end

  def get_position(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate].position
  end

  def value_changed?(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate].changed
  end

  def map_position_to_coordinate(position)
    map = position_to_coordinate_map
    map[position.to_s]
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

  def position_to_coordinate_map
    map = {}

    row_iterator = 0
    @max_height.times do
      column_iterator = 0
      @max_width.times do
        position = get_position(row_iterator, column_iterator).to_s
        map[position] = [row_iterator, column_iterator]
        column_iterator += 1
      end
      row_iterator += 1
    end

    map
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
