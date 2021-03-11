# frozen_string_literal: true

# board init helper for slimming down main board class
module BoardInit
  def black_side_first
    board[0] = [
      Rook.new([0, 0], 'black'),
      Knight.new([0, 1], 'black'),
      Bishop.new([0, 2], 'black'),
      Queen.new([0, 3], 'black'),
      King.new([0, 4], 'black'),
      Bishop.new([0, 5], 'black'),
      Knight.new([0, 6], 'black'),
      Rook.new([0, 7], 'black')
    ]
  end

  def black_side_pawns
    board[1].each_index do |index|
      board[1][index] = Pawn.new([1, index], 'black')
    end
  end

  def white_side_first
    board[7] = [
      Rook.new([7, 0], 'white'),
      Knight.new([7, 1], 'white'),
      Bishop.new([7, 2], 'white'),
      Queen.new([7, 3], 'white'),
      King.new([7, 4], 'white'),
      Bishop.new([7, 5], 'white'),
      Knight.new([7, 6], 'white'),
      Rook.new([7, 7], 'white')
    ]
  end

  def white_side_pawns
    board[6].each_index do |index|
      board[6][index] = Pawn.new([6, index], 'white')
    end
  end
end
