class String
  def blue
    "\e[34m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end
end
