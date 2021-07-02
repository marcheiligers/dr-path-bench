module MergeSortStandard
  def merge_sort(unsorted_array, target_x, target_y)
      # if array only has one element or fewer there is nothing to do
      if unsorted_array.length <=1
          return unsorted_array
      else
          # dividing and then merge-sorting the halves
          mid = unsorted_array.length/2
          first_half = merge_sort(unsorted_array.slice(0...mid), target_x, target_y)
          second_half = merge_sort(unsorted_array.slice(mid...unsorted_array.length), target_x, target_y)
          merge(first_half, second_half, target_x, target_y)
      end
  end

  def merge(left_array, right_array, target_x, target_y)
      sorted_array = []
      # If either array is empty we don't need to compare them
      while !left_array.empty? && !right_array.empty? do
          # we are shifting out the compared/used values so we don't repeat
          if ((target_x - left_array[0][0]).abs + (target_y - left_array[0][1]).abs) < ((target_x - right_array[0][0]).abs + (target_y - right_array[0][1]).abs)
              sorted_array.push(left_array.shift)
          else
              sorted_array.push(right_array.shift)
          end
      end
      #concat appends elements of another array to an array
      return sorted_array.concat(left_array).concat(right_array)
  end
end
