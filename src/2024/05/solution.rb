require_relative '../../CalendarDate.rb'

class Solution < CalendarDate
  def initialize
    super(5)

    # test data
#     @data =
# "47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13

# 75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47"

    @rules, @input = @data.split("\n\n").map do |item|
      item.split("\n")
    end

    @rules = @rules.map {|x| x.split("|")}
    @input = @input.map do |item|
      item.split(",")
    end

    # puts "Rules: #{@rules}"
    # puts "Input: #{@input}"

    puts "Part 1"
    puts "Question: how many of the input strings are in the correct order?"

    sum = 0
    @input.each do |item|
      correct = correct_order(item)
      sum += middle(item).to_i if correct
      puts "Correct Order: #{item}" if correct
      puts "Incorrect Order: #{item}" if !correct
    end

    puts "Answer: #{sum}"

    puts "Part 2"
    puts "Question: Sort the incorrect inputs and total the middle numbers"

    sum = 0
    @input.each do |item|
      correct = correct_order(item)
      puts "correct: #{correct}" if correct
      next if correct
      fixed = sort(item)
      puts "Fixed Order: #{fixed}"
      sum += middle(fixed).to_i

    end

    puts "Answer: #{sum}"

  end

  def order_allowed (a,b) #number, number
    # is A allowed to be before B?
    @rules.select {|x| x[1] == b}.map(&:first).include?(a)
  end

  def correct_order (arr) #number[]
    arr.each_with_index do |item, index|
      if index < arr.length-1
        return false if !order_allowed(item, arr[index+1])
      end
    end
    return true
  end

  def middle(arr)
    arr[arr.length/2]
  end

  def sort(arr)
    arr.sort do |a,b|
      order_allowed(a,b) ? -1 : 1
    end
  end
end

Solution.new
