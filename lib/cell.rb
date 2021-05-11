class Cell
  attr_reader :position, :value

  def initialize(position = 0, value = nil)
    @position = position
    @value = value.nil? ? position : value
    @value_changed = false
  end

  def write_value(value)
    if @value_changed == false && %w[X O].include?(value)
      @value = value
      @value_changed = true
      'sucess'
    elsif @value_changed
      'value already changed'
    else
      'must be X or O'
    end
  end
end
