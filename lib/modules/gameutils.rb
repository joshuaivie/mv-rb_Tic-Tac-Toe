module GameUtils
  def clear_screen
    system('clear') || system('cls')
  end

  def word_wrap(words, indent = 0)
    character_array = words.split('')
    new_character_array = []
    reset_counter = 0

    terminal_width = `tput cols`.to_i
    maximum_length = terminal_width - (terminal_width * 0.15)

    character_array.each do |character|
      if character == "\n"
        reset_counter = 0
      elsif reset_counter >= maximum_length && character == ' '
        if indent.positive?
          new_character_array << "\n"
          (0...(indent - 1)).each do |_i|
            new_character_array << ' '
            reset_counter += 1
          end
          reset_counter = 0
        else
          character = "\n"
          reset_counter = 0
        end
      end
      new_character_array << character
      reset_counter += 1
    end

    new_character_array.join.to_s
  end
end
