module MergeSortInlinePrecalcHeuristic
  def merge_sort(unsorted_array)
    # if array only has one element or fewer there is nothing to do
    return unsorted_array if unsorted_array.length <=1

    # dividing and then merge-sorting the halves
    mid = unsorted_array.length/2
    first_half = merge_sort(unsorted_array[0, mid])
    second_half = merge_sort(unsorted_array[mid..-1])
    sorted_array = []
    # If either array is empty we don't need to compare them
    while !first_half.empty? && !second_half.empty? do
      # we are shifting out the compared/used values so we don't repeat
      sorted_array.push first_half[0][2] < second_half[0][2] ? first_half.shift : second_half.shift
    end
    #concat appends elements of another array to an array
    sorted_array.concat(first_half).concat(second_half)
  end
end
