class Cell
  attr_reader :position, :value, :changed

  def initialize(position = 0, value = nil)
    @position = position
    @value = value.nil? ? position : value
    @changed = false
  end

  def write_value(value)
    if @changed == false && %w[X O].include?(value)
      @value = value
      @changed = true
      'sucess'
    elsif @changed
      'value already changed'
    else
      'must be X or O'
    end
  end
end
