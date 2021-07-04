class GreedyMergeSortPrecalcHeuristicNewConcat
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
      adjacent_neighbors << [nfx - 1, nfy - 1, (target_x - nfx + 1).abs + (target_y - nfy + 1).abs] unless nfx == 0 || nfy == 0
      adjacent_neighbors << [nfx - 1, nfy    , (target_x - nfx + 1).abs + (target_y - nfy).abs] unless nfx == 0
      adjacent_neighbors << [nfx - 1, nfy + 1, (target_x - nfx + 1).abs + (target_y - nfy - 1).abs] unless nfx == 0 || nfy == max_y
      adjacent_neighbors << [nfx    , nfy + 1, (target_x - nfx).abs + (target_y - nfy - 1).abs] unless nfy == max_y
      adjacent_neighbors << [nfx + 1, nfy + 1, (target_x - nfx - 1).abs + (target_y - nfy - 1).abs] unless nfx == max_x || nfy == max_y
      adjacent_neighbors << [nfx + 1, nfy    , (target_x - nfx - 1).abs + (target_y - nfy).abs] unless nfx == max_x
      adjacent_neighbors << [nfx + 1, nfy - 1, (target_x - nfx - 1).abs + (target_y - nfy + 1).abs] unless nfx == max_x || nfy == 0

      new_neighbors = adjacent_neighbors.select do |neighbor|
        # That have not been visited and are not walls
        unless came_from.has_key?(neighbor) || map[neighbor[1]][neighbor[0]] != '.'
          # Add them to the frontier and mark them as visited
          # frontier << neighbor
          came_from[neighbor] = new_frontier
        end
      end

      # Sort the frontier so cells that are close to the target are then prioritized
      if new_neighbors.length > 0
        new_neighbors = merge_sort(new_neighbors)
        if frontier.length > 0 && new_neighbors[0][2] >= frontier[0][2]
          frontier = merge_sort(new_neighbors.concat(frontier))
        else
          frontier = new_neighbors.concat(frontier)
        end
      end
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
