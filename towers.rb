def make_board(size)
  {
    "1" => (1..size.to_i).to_a,
    "2" => [],
    "3" => []
  }
end

def prompt(question = "What's your move? >> ")
  puts question
  gets.chomp
end

def player_input(board)
  input = prompt()
  return input if input == 'quit'
  movement = input.scan(/\d/)
  move_valid?(movement, board) ? movement : player_input(board)
end

def move_valid?(movement, board)
  return true if movement == 'quit'

  # Input must have correct format
  return false if movement.length != 2

  from_tower, to_tower = movement

  # Towers must exist
  unless board[from_tower] && board[to_tower]
    puts "Must use valid tower positions."
    return false
  end
  # There must be a disk to move
  if board[from_tower].empty?
    puts 'There must be disks at the first tower.'
    return false
  end
  # Will not lay a larger on a smaller
  if !board[to_tower].empty?
    if board[from_tower][0] > board[to_tower][0]
      puts 'You cannot place larger disks on smaller disks.'
      return false
    end
  end

  true
end

def move(movement, board)
  from_tower, to_tower = movement

  moved_disk = board[from_tower].shift
  board[to_tower].unshift(moved_disk)
end

def render(board)
  board.each do |position, disks|
    puts "Position #{position}"
    disks.each do |disk|
      puts '#' * disk
    end
  end
end

def check_win(board)
  board['1'].empty? && board['2'].empty?
end

def play
  size = prompt("What size should the board be? >> ")
  board = make_board(size)
  render(board)

  game_over = false
  while !game_over
    action = player_input(board)

    if action == 'quit'
      puts 'Boo, you quit.'
      game_over = true
    else
      move(action, board)
      render(board)
      if check_win(board)
        game_over = true
        puts "You won!"
      end
    end
  end
end