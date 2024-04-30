def add(numbers)
  return 0 if numbers.empty?
  
  delimiter = ","
  if numbers.start_with?("//")
    delimiter = numbers[2]
    numbers = numbers[4..-1]
  end

  numbers = numbers.gsub("\n", delimiter)

  if numbers.include?(",\n")
    raise ArgumentError, "Invalid input format"
  end

  nums = numbers.split(/#{Regexp.escape(delimiter)}|\n/)

  negatives = nums.select { |num| num.start_with?("-") }.map(&:to_i)
  if negatives.any?
    raise ArgumentError, "Negative numbers not allowed: #{negatives.join(', ')}"
  end

  nums.map(&:to_i).reduce(:+)
end

# Test cases
raise "Test Case 1 Failed" unless add("") == 0
raise "Test Case 2 Failed" unless add("1") == 1
raise "Test Case 3 Failed" unless add("1,5") == 6
raise "Test Case 4 Failed" unless add("1\n2,3") == 6
raise "Test Case 5 Failed" unless add("//;\n1;2") == 3

begin
  add("1,\n")
rescue ArgumentError => e
  raise "Test Case 6 Failed" unless e.message == "Invalid input format"
end

begin
  add("-1,2,-3")
rescue ArgumentError => e
  raise "Test Case 7 Failed" unless e.message == "Negative numbers not allowed: -1, -3"
end
