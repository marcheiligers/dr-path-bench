# TARGET = [31, 31]
TARGET = [20, 11]

# SOURCE = [20, 11]
SOURCE = [31, 31]


def tick args
  args.outputs.labels << [100, 100, "Press R to run bench"]
  args.outputs.labels << [100, 120, "Press P to output paths"]

  if args.inputs.keyboard.key_down.r
    args.gtk.console.show
    args.gtk.benchmark iterations: 10, # number of iterations
                       greedy_standard: -> () {
                         greedy = GreedyStandard.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_merge_sort: -> () {
                         greedy = GreedyMergeSort.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_sort_bang: -> () {
                         greedy = GreedySortBang.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       # greedy_path_tile: -> () {
                       #   greedy = GreedyPathTile.new
                       #   greedy.find_path(PathTile.new(SOURCE[0], SOURCE[1]), PathTile.new(TARGET[0], TARGET[1]), Maps::MAP1)
                       #   puts greedy.main_loop_count
                       # },
                       greedy_sort_bang_new_concat: -> () {
                         greedy = GreedySortBangNewConcat.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_sort_bang_precalc_heuristic: -> () {
                         greedy = GreedySortBangPrecalcHeuristic.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_merge_sort_precalc_heuristic: -> () {
                         greedy = GreedyMergeSortPrecalcHeuristic.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_merge_sort_precalc_heuristic_elm_ref: -> () {
                         greedy = GreedyMergeSortPrecalcHeuristicElmRef.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_merge_sort_precalc_heuristic_new_concat: -> () {
                         greedy = GreedyMergeSortPrecalcHeuristicNewConcat.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       }
  end

  if args.inputs.keyboard.key_down.p
    args.gtk.console.show

    puts :greedy_standard
    greedy = GreedyStandard.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1).inspect
    puts greedy.main_loop_count

    puts :greedy_merge_sort
    greedy = GreedyMergeSort.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count

    puts :greedy_sort_bang
    greedy = GreedySortBang.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count

    # puts :greedy_sort_bang_new_concat
    # greedy = GreedySortBangNewConcat.new
    # puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    # puts greedy.main_loop_count

    puts :greedy_sort_bang_precalc_heuristic
    greedy = GreedySortBangPrecalcHeuristic.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count

    puts :greedy_merge_sort_precalc_heuristic
    greedy = GreedyMergeSortPrecalcHeuristic.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count

    puts :greedy_merge_sort_precalc_heuristic_elm_ref
    greedy = GreedyMergeSortPrecalcHeuristicElmRef.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count

    puts :greedy_merge_sort_precalc_heuristic_new_concat
    greedy = GreedyMergeSortPrecalcHeuristicNewConcat.new
    puts greedy.find_path(SOURCE, TARGET, Maps::MAP1)
    puts greedy.main_loop_count
  end
end
