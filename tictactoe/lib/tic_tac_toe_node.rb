require_relative 'tic_tac_toe'


class TicTacToeNode
  attr_reader :board, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

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
      # board_dup = @board.dup
      # board_dup[pos] = @next_mover_mark
      # if @next_mover_mark == :x
      #  @next_mover_mark = :o
      # else
      #   @next_mover_mark = :x
      # end
      # add_node = TicTacToeNode.new(board_dup, @next_mover_mark, pos)
      # dup
      #
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
