# dr-path-bench

## Benchmarking Path Finding Algorithms for DRGTK

The Greedy algorithm was extracted from the [DRGTK Examples](http://docs.dragonruby.org/#----path-finding-algorithms---heuristic-with-walls---main-rb). Merge sort was taken from the [Merge Sort in Ruby](https://medium.com/@allegranzia/merge-sort-in-ruby-102b750af287) by Alessandro Allegranzi. Both have been modified for performance.

## Running

Clone this repo into your DragonRuby directory and then run `./dragonruby dr-path-bench`. Requires at least DragonRuby 2.19 for the benchmarking functions.

## Results

On my ancient MacBook Pro (Retina, 15-inch, Early 2013), 2.7 GHz Quad-Core Intel Core i7, 16 GB 1600 MHz DDR3, NVIDIA GeForce GT 650M 1 GB, the results are as follows:

```bash
* BENCHMARK:
** Fastest: :greedy_merge_sort_precalc_heuristic
** Second:  :greedy_sort_bang_precalc_heuristic
** Margin:  41% (224ms) 435ms vs 659ms.
** Times:
*** greedy_merge_sort_precalc_heuristic: 435ms (0% 0ms).
*** greedy_sort_bang_precalc_heuristic: 659ms (40% 224ms).
*** greedy_merge_sort: 765ms (55% 330ms).
*** greedy_sort_bang: 1014ms (79% 580ms).
*** greedy_standard: 1901ms (125% 1466ms).
```

That means the pure Ruby `merge_sort` is faster than even the built in `sort!`, and precalculating the heuristic function instead of calculating in the sort improves the performance by another 40%. It should be noted that the merge sort version goes through the main loop fewer times for these starting conditions (58 times vs 68 times), though the resulting paths are identical. Different starting conditions may have differing results.

