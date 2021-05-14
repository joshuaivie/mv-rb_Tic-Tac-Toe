module GameText
  WELCOME_MESSAGE = "Welcome to Boaz and Joshua's Tic Tac Toe Game".freeze
  INSTRUCTIONS = ['The game is played on a 3 by 3 sqaure grid by two players',
                  'At the start of the game players select thier position as X (Player 1) or O (Player 2)',
                  'Players take turns putting their marks in empty squares by inputting a number corresponding to
                  the square in which they want to play',
                  'The first player to get 3 marks in a row (up, down, across, or diagonally) is the winner',
                  'When all 9 squares are full, the game is over. If no player has 3 marks in a row,
                  the game ends in a tie.'].freeze
  EXIT_MESSAGE = ['Thank you for playing our game', 'Have a great day!'].freeze
  INTERRUPT_MESSAGE = ["\nWe're sorry to see you go.\nExiting..."].freeze
end
