module MergeSortIterativePrecalcHeuristic
  # Merge two sorted sublists `arr[frm…mid]` and `arr[mid+1…to]`
  def merge(arr, temp, frm, mid, to)
    k = frm
    i = frm
    j = mid + 1

    # loop till no elements are left in the left and right runs
    while i <= mid && j <= to
      if arr[i][2] < arr[j][2]
        temp[k] = arr[i]
        i = i + 1
      else
        temp[k] = arr[j]
        j = j + 1
      end

      k = k + 1
    end

    # copy remaining elements
    while i < arr.length && i <= mid
      temp[k] = arr[i]
      k = k + 1
      i = i + 1
    end

    # no need to copy the second half (since the remaining items
    # are already in their correct position in the temporary array)

    # copy back to the original list to reflect sorted order
    for i in (frm...to + 1)
      arr[i] = temp[i]
    end
  end


  # Iteratively sort sublist `arr[low…high]` using a temporary list
  def merge_sort!(arr)
    low = 0
    high = arr.length - 1

    # sort list `arr` using a temporary list `temp`
    temp = arr.dup

    # divide the list into blocks of size `m`
    # m = [1, 2, 4, 8, 16…]
    m = 1
    while m <= high - low do
      # for m = 1, i = [0, 2, 4, 6, 8…]
      # for m = 2, i = [0, 4, 8, 12…]
      # for m = 4, i = [0, 8, 16…]
      # …
      low.step(high, 2*m) do |i|
        frm = i
        mid = i + m - 1
        to = [i + 2*m - 1, high].min
        merge(arr, temp, frm, mid, to)
      end

      m = 2*m
    end
  end

  # def merge_sort(unsorted_array)
  #   # if array only has one element or fewer there is nothing to do
  #   return unsorted_array if unsorted_array.length <=1

  #   # dividing and then merge-sorting the halves
  #   mid = unsorted_array.length/2
  #   first_half = merge_sort(unsorted_array[0, mid])
  #   second_half = merge_sort(unsorted_array[mid..-1])
  #   sorted_array = []
  #   # If either array is empty we don't need to compare them
  #   while !first_half.empty? && !second_half.empty? do
  #     # we are shifting out the compared/used values so we don't repeat
  #     sorted_array.push first_half[0][2] < second_half[0][2] ? first_half.shift : second_half.shift
  #   end
  #   #concat appends elements of another array to an array
  #   sorted_array.concat(first_half).concat(second_half)
  # end
end
