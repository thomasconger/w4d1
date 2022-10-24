require_relative '00_tree_node.rb'

require 'byebug'

class KnightPathFinder

    attr_reader :path, :considered_positions

    def self.root_node(starting_pos)
        root = PolyTreeNode.new(starting_pos)
    end

    def self.is_legal_position?(pos)
        row, col = pos
        row.between?(0,7) && col.between?(0,7)
    end

    def self.valid_moves(pos)
        row, col = pos
        moves = []

        pos_delta = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

        pos_delta.each do |delta|
            delta_row, delta_col = delta
            new_pos = [row + delta_row, col + delta_col]
            moves << new_pos if is_legal_position?(new_pos)
        end

        moves
    end

    def initialize(starting_pos)
        @starting_node = KnightPathFinder.root_node(starting_pos)
        @path = [starting_pos]
        @considered_positions = [starting_pos]

    end

    def new_move_positions(pos)
        valids = KnightPathFinder.valid_moves(pos)
        valids.reject { |position| @considered_positions.include?(position) }
    end

    def build_move_tree
        queue = [@starting_node]

        until queue.empty?
            el = queue.shift
            # debugger
            new_move_positions(el.value).each do |position|
                unless @considered_positions.include?(position)
                    # Make a new child from teh position
                    new_child = PolyTreeNode.new(position)
                    # Push new_child onto end of array
                    queue.push(new_child)
                    # Add new_child to its parent
                    el.add_child(new_child)
                    # Add position to considered positions so it doesn't appear again
                    @considered_positions << position
                end
            end
        end

        return @starting_node
    end

    def find_path(pos)
        #stage 1 was just find the node that contains the passed in position in val
        trace_path_back(@starting_node.bfs(pos))
    end

    def trace_path_back(node)
        path = [node.value]
            until node.parent.nil?
                node = node.parent
                path.unshift(node.value)
            end
        path
    end


end


# kpf = KnightPathFinder.new([0, 0])

# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]


# k = KnightPathFinder.new([0,0])
