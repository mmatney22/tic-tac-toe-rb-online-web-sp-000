#display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

#input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end

#move
def move(board, index, token)
  board[index] = token
end

#position_taken?
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

#valid_move?
def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

#turn
def turn(board)
  puts "Please enter a number between 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Whoops! That's not a valid move."
    turn(board)
  end
end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
  counter += 1
    end
  end
  counter
end

#current_player
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#won?
def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
  position_1 = board[win_combo[0]]
  position_2 = board[win_combo[1]]
  position_3 = board[win_combo[2]]

  position_1 == position_2 && position_2 == position_3 &&
  position_taken?(board, win_combo[0])
  end
end

#full
def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

#draw
def draw?(board)
  !won?(board) && full?(board)
end

#over
def over?(board)
  won?(board) || draw?(board)
end

#winner
def winner(board)
  won?(board) && board[won?(board)[0]]
end

#play
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
