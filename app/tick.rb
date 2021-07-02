# TARGET = [40, 30]
TARGET = [20, 11]
# SOURCE = [11, 22]
# SOURCE = [27, 35]
SOURCE = [31, 31]

def tick args
  args.outputs.labels << [100, 100, "Press R to run bench"]
  args.outputs.labels << [100, 120, "Press P to output paths"]
  # press r to run benchmark
  if args.inputs.keyboard.key_down.r
    args.gtk.console.show
    args.gtk.benchmark iterations: 10, # number of iterations
                       # label for experiment
                       greedy_standard: -> () {
                         # experiment body
                         greedy = GreedyStandard.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_merge_sort: -> () {
                         # experiment body
                         greedy = GreedyMergeSort.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       },
                       greedy_sort_bang: -> () {
                         # experiment body
                         greedy = GreedySortBang.new
                         greedy.find_path(SOURCE, TARGET, Maps::MAP1)
                         puts greedy.main_loop_count
                       }
                       # ,
                       # greedy_path_tile: -> () {
                       #   # experiment body
                       #   greedy = GreedyPathTile.new
                       #   greedy.find_path(PathTile.new(SOURCE[0], SOURCE[1]), PathTile.new(TARGET[0], TARGET[1]), Maps::MAP1)
                       #   puts greedy.main_loop_count
                       # }
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
  end
end
