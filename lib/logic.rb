module GameLogic
  def winning_coordinates(max_width, max_height)
    coordinates_array = []

    # Get Horizontals
    row_iterator = 0
    max_height.times do
      column_iterator = 0
      row = []
      max_width.times do
        coordinate = [row_iterator, column_iterator]
        row << coordinate
        column_iterator += 1
      end
      coordinates_array << row
      row_iterator += 1
    end

    # Get Verticals
    column_iterator = 0
    max_height.times do
      row_iterator = 0
      column = []
      max_width.times do
        coordinate = [row_iterator, column_iterator]
        column << coordinate
        row_iterator += 1
      end
      coordinates_array << column
      column_iterator += 1
    end

    # Get Left Diagonal
    column_iterator = 0
    row_iterator = 0
    diagonal = []
    max_width.times do
      coordinate = [row_iterator, column_iterator]
      diagonal << coordinate
      row_iterator += 1
      column_iterator += 1
    end
    coordinates_array << diagonal

    # Get Right Diagonal
    column_iterator = (max_width - 1)
    row_iterator = 0
    diagonal = []
    max_width.times do
      coordinate = [row_iterator, column_iterator]
      diagonal << coordinate
      row_iterator += 1
      column_iterator -= 1
    end
    coordinates_array << diagonal

    coordinates_array
  end

  def run_combinations(board, winning_coordinates)
    values_array = []

    winning_coordinates.each do |array|
      current_values = []
      array.each do |coordinate|
        value = board.get_value(coordinate[0], coordinate[1])
        current_values << value
      end
      values_array << current_values
    end

    values_array
  end
end
