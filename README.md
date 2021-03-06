# dr-path-bench

## Benchmarking Path Finding Algorithms for DRGTK

The Greedy algorithm was extracted from the [DRGTK Examples](http://docs.dragonruby.org/#----path-finding-algorithms---heuristic-with-walls---main-rb). Merge sort was taken from the [Merge Sort in Ruby](https://medium.com/@allegranzia/merge-sort-in-ruby-102b750af287) by Alessandro Allegranzi. Both have been modified for performance.

## Running

Clone this repo into your DragonRuby directory and then run `./dragonruby dr-path-bench`. Requires at least DragonRuby 2.19 for the benchmarking functions.

## Results

On my ancient MacBook Pro (Retina, 15-inch, Early 2013), 2.7 GHz Quad-Core Intel Core i7, 16 GB 1600 MHz DDR3, NVIDIA GeForce GT 650M 1 GB, the results are as follows:

```bash
* BENCHMARK:
** Fastest: :greedy_merge_sort_precalc_heuristic_new_concat
** Second:  :greedy_merge_sort_precalc_heuristic
** Margin:  17% (69ms) 361ms vs 430ms.
** Times:
*** greedy_merge_sort_precalc_heuristic_new_concat: 361ms (0% 0ms).
*** greedy_merge_sort_precalc_heuristic: 430ms (17% 69ms).
*** greedy_merge_sort_precalc_heuristic_elm_ref: 448ms (21% 87ms).
*** greedy_sort_bang_new_concat: 667ms (59% 306ms).
*** greedy_sort_bang_precalc_heuristic: 676ms (60% 315ms).
*** greedy_merge_sort_iterative_precalc_heuristic_new_concat: 759ms (71% 398ms).
*** greedy_merge_sort: 767ms (71% 406ms).
*** greedy_sort_bang: 1002ms (94% 642ms).
*** greedy_standard: 1984ms (138% 1623ms).
```

That means the pure Ruby `merge_sort` is faster than even the built in `sort!`, and precalculating the heuristic function instead of calculating in the sort improves the performance by another chunck, and selectively sorting even more. It should be noted that the merge sort version goes through the main loop fewer times for these starting conditions (58 times vs 68 times), though the resulting paths are identical. Different starting conditions may have differing results.

