require_relative 'tic_tac_toe'


class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

    if @board.over?
      if @board.winner == evaluator || @board.tied?
        return false
      else
        return true
      end
    end

    if evaluator == @next_mover_mark
      #see if we lose in all instances
      children.all? { |child| child.losing_node?(evaluator) }
    else
      # See if opponent can make us lose in any instance
      children.any? { |child| child.losing_node?(evaluator) }
    end


    #if we lose, then return true
    #returning a boolean, where it is false if we win or at least dont lose
  end

  def winning_node?(evaluator)



  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_positions = []

    @board.rows.each_with_index do |row, ri|
      row.each_with_index do |el, ci|
        if el == nil
          empty_positions << [ri, ci]
        end
      end
    end

    empty_positions.map do |pos|

      board_dup = @board.dup
      board_dup[pos] = @next_mover_mark
      if @next_mover_mark == :x
        temp = :o
      else
        temp = :x
      end
      TicTacToeNode.new(board_dup, temp, pos)
    end
  end
end
