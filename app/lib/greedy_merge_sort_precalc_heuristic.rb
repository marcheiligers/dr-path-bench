class GreedyMergeSortPrecalcHeuristic
  include MergeSortPrecalcHeuristic

  attr_reader :main_loop_count

  # source and target are simple points [x, y], map is an array of arrays where '.' is walkable, and anything else is not
  def find_path(source, target, map)
    @main_loop_count = 0

    max_y = map.size - 1
    max_x = map[0].size - 1
    target_x = target[0]
    target_y = target[1]
    # target heuristic is 0
    target = [target_x, target_y, 0]

    # Sets up the search to begin from the source
    source = source.dup.push((target_x - source[0]).abs + (target_y - source[1]).abs)
    came_from = {}
    came_from[source] = nil
    frontier  = [source]

    # Until the target is found or there are no more cells to explore from
    until came_from.has_key?(target) || frontier.empty?
      @main_loop_count += 1

      # Take the next frontier cell
      new_frontier = frontier.shift

      # Find the adjacent neighbors
      adjacent_neighbors = []

      # Gets all the valid adjacent_neighbors into the array
      # From southern neighbor, clockwise
      nfx = new_frontier[0]
      nfy = new_frontier[1]
      adjacent_neighbors << [nfx    , nfy - 1, (target_x - nfx).abs + (target_y - nfy + 1).abs] unless nfy == 0
      adjacent_neighbors << [nfx - 1, nfy    , (target_x - nfx + 1).abs + (target_y - nfy).abs] unless nfx == 0
      adjacent_neighbors << [nfx    , nfy + 1, (target_x - nfx).abs + (target_y - nfy - 1).abs] unless nfy == max_y
      adjacent_neighbors << [nfx + 1, nfy    , (target_x - nfx - 1).abs + (target_y - nfy).abs] unless nfx == max_x

      adjacent_neighbors << [nfx - 1, nfy - 1, (target_x - nfx + 1).abs + (target_y - nfy + 1).abs] unless nfx == 0 || nfy == 0
      adjacent_neighbors << [nfx - 1, nfy + 1, (target_x - nfx + 1).abs + (target_y - nfy - 1).abs] unless nfx == 0 || nfy == max_y
      adjacent_neighbors << [nfx + 1, nfy + 1, (target_x - nfx - 1).abs + (target_y - nfy - 1).abs] unless nfx == max_x || nfy == max_y
      adjacent_neighbors << [nfx + 1, nfy - 1, (target_x - nfx - 1).abs + (target_y - nfy + 1).abs] unless nfx == max_x || nfy == 0

      # For each of its neighbors
      # adjacent_neighbors(new_frontier).each do |neighbor|
      adjacent_neighbors.each do |neighbor|
        # Precalc the heuristic function
        # neighbor << (target_x - neighbor[0]).abs + (target_y - neighbor[1]).abs

        # That have not been visited and are not walls
        unless came_from.has_key?(neighbor) || map[neighbor[1]][neighbor[0]] != '.'
          # Add them to the frontier and mark them as visited
          frontier << neighbor
          came_from[neighbor] = new_frontier
        end
      end

      # puts frontier.inspect

      # Sort the frontier so cells that are close to the target are then prioritized
      # frontier = frontier.sort_by { |cell| (target_x - cell[0]).abs + (target_y - cell[1]).abs }
      # frontier.sort! { |c1, c2| c1[2] <=> c2[2]  }
      frontier = merge_sort(frontier)
    end

    # If the search found the target
    if came_from.has_key?(target)
      # Calculates the path between the target and star for the greedy search
      # Only called when the greedy search finds the target
      path = []
      next_endpoint = came_from[target]
      while next_endpoint
        path << [next_endpoint[0], next_endpoint[1]]
        next_endpoint = came_from[next_endpoint]
      end
      path
    else
      return nil
    end
  end
end
