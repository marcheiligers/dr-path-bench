# Original test cases
# TARGET = [31, 31]
TARGET = [20, 11]

# SOURCE = [20, 11]
SOURCE = [31, 31]

# Concats have longer path path
# SOURCE = [1, 20]
# TARGET = [12, 42]

# SOURCE = [40, 40]
# TARGET = [32, 12]

# Super slow for all but greedy_merge_sort_precalc_heuristic_new_concat
# SOURCE = [7, 29]
# TARGET = [46, 6]

def tick args
  args.outputs.labels << [100, 120, "Press R to run bench with random source and target"]
  args.outputs.labels << [100, 100, "Press O to run bench with original test case"]

  if args.inputs.keyboard.key_down.r
    source = safe_point
    target = safe_point(source)
    bench(source, target, args)
    paths(source, target, args)
  end

  if args.inputs.keyboard.key_down.o
    bench(SOURCE, TARGET, args)
    paths(SOURCE, TARGET, args)
  end
end

def bench(source, target, args)
  args.gtk.console.show
  args.gtk.benchmark iterations: 10, # number of iterations
                     greedy_standard: -> () { GreedyStandard.new.find_path(source, target, Maps::MAP1) },
                     greedy_merge_sort: -> () { GreedyMergeSort.new.find_path(source, target, Maps::MAP1) },
                     greedy_sort_bang: -> () { GreedySortBang.new.find_path(source, target, Maps::MAP1) },
                     # greedy_path_tile: -> () { GreedyPathTile.new.find_path(PathTile.new(SOURCE[0], SOURCE[1]), PathTile.new(TARGET[0], TARGET[1]), Maps::MAP1) },
                     greedy_sort_bang_new_concat: -> () { GreedySortBangNewConcat.new.find_path(source, target, Maps::MAP1) },
                     greedy_sort_bang_precalc_heuristic: -> () { GreedySortBangPrecalcHeuristic.new.find_path(source, target, Maps::MAP1) },
                     greedy_merge_sort_precalc_heuristic: -> () { GreedyMergeSortPrecalcHeuristic.new.find_path(source, target, Maps::MAP1) },
                     greedy_merge_sort_precalc_heuristic_elm_ref: -> () { GreedyMergeSortPrecalcHeuristicElmRef.new.find_path(source, target, Maps::MAP1) },
                     greedy_merge_sort_precalc_heuristic_new_concat: -> () { GreedyMergeSortPrecalcHeuristicNewConcat.new.find_path(source, target, Maps::MAP1) }
end

def paths(source, target, args)
  puts :greedy_standard
  greedy = GreedyStandard.new
  puts greedy.find_path(source, target, Maps::MAP1).inspect
  puts greedy.main_loop_count

  puts :greedy_merge_sort
  greedy = GreedyMergeSort.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_sort_bang
  greedy = GreedySortBang.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_sort_bang_new_concat
  greedy = GreedySortBangNewConcat.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_sort_bang_precalc_heuristic
  greedy = GreedySortBangPrecalcHeuristic.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_merge_sort_precalc_heuristic
  greedy = GreedyMergeSortPrecalcHeuristic.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_merge_sort_precalc_heuristic_elm_ref
  greedy = GreedyMergeSortPrecalcHeuristicElmRef.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts :greedy_merge_sort_precalc_heuristic_new_concat
  greedy = GreedyMergeSortPrecalcHeuristicNewConcat.new
  puts greedy.find_path(source, target, Maps::MAP1)
  puts greedy.main_loop_count

  puts "SOURCE = #{source.inspect}\nTARGET = #{target.inspect}"
end

def safe_point(other = nil)
  while true
    point = [rand(50), rand(50)]
    return point if Maps::MAP1[point[1]][point[0]] == '.' && (!other || other != point)
  end
end
