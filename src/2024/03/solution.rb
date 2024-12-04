require_relative '../../CalendarDate.rb'

class Solution < CalendarDate
  def initialize
    super(3)
    @mulRegex = /(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/m
    @numRegex = /(\d{1,3}),(\d{1,3})/
    part1
    part2
  end


  def part1
    puts "Part 1"

    puts "Quesiton: find all instaces of mul(###,###), multiply and return the sum"
    sum = 0
    scannedData.each do |match|
      next if match[0].nil?
      sum += mul(match[0]).to_i
    end
    puts "Sum: #{sum}"
  end

  def part2
    puts "Part 2"
    puts "Quesiton: find all instaces of mul(###,###), multiply and return the sum. This time do() and don't() enable and disable the mull instances in sequence."
    sum = 0
    enabled = true
    scannedData.each do |match|
      mulStr = match[0]
      doStr = match[1]
      dontStr = match[2]

      enabled = true if doStr
      enabled = false if dontStr
      next unless mulStr
      next unless enabled
      sum += mul(match[0])
    end
    puts "Sum: #{sum}"
  end

  def mul(match)
    match.scan(@numRegex) do |num1, num2|
      return num1.to_i * num2.to_i
    end
  end

  def scannedData
    @data.scan(@mulRegex)
  end

end

Solution.new
