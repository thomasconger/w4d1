require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    board_state = TicTacToeNode.new(game.board, mark)
    kids = board_state.children
    # debugger
    kids.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    kids.each do |child|
      unless child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "no non-losing nodes"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
