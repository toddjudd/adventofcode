require_relative '../../CalendarDate.rb'

class Integer
  def even_digits?
    self.digits.even?
  end

  def digits
    Math.log10(self).to_i + 1
  end
end

class Solution < CalendarDate
  def initialize
    super(11)

    @stoneCount = 0

    # @data = '125 17'.split(' ').map {|x| x.to_i} # Test Data
    @data = @data.split(' ').map {|x| x.to_i} # map data
    # @testAnswers = [3,4, 5, 9, 13, 22]
    @blinks = 75

    @mathCache = {0=>1} # stoneValue => result same math will always be applied
    # part of me want's to prbuild the cache. I wonder what efficiency gains that would have.
    @scoreCache = {} # "value,blinks" => result


    puts "Data: #{@data}"
    puts "Blinks: #{@blinks}"
    # puts "Expected: #{@testAnswers[@blinks-1]}"

    @data.each do |value|
      @stoneCount += score(value, 1)
    end

    puts "Stone Count: #{@stoneCount}"
  end

  def applyRule(value) # nubmer => [int] | int
    return @mathCache[value] if @mathCache[value]

    if value.even_digits?
      lenght = value.digits
      a = value / 10**(lenght/2)
      b = value % 10**(lenght/2)
      @mathCache[value] = [a,b]
      return [a,b]
    end

    product = value*2024

    @mathCache[value] = product
    return product

  end

  def score(value, blinks) # int, int => int
    return @scoreCache["#{value},#{blinks}"] if @scoreCache["#{value},#{blinks}"]

    return 1 if blinks > @blinks

    ruleResult = applyRule(value)

    if ruleResult.is_a? Array
       @scoreCache["#{value},#{blinks}"]  = score(ruleResult[0], blinks+1) + score(ruleResult[1], blinks+1)
    else
       @scoreCache["#{value},#{blinks}"]  = score(ruleResult, blinks+1)
    end
  end

end

Solution.new
