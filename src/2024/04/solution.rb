require_relative '../../CalendarDate.rb'

class Solution < CalendarDate
  def initialize
    super(4)

    # convert the data to a 2d array
    @data = @data.split("\n").map do |line|
      line.split("")
    end

    # testMove
    # run soloution
    part1
    part2
  end

  def move(arr,x,y,direction)
    xd = direction[0]
    yd = direction[1]

    x1 = x + xd
    y1 = y + yd

    if x1 < 0 || y1 < 0 || x1 > @data.length-1 || y1 > @data[x1].length-1
      return ["Z",-1,-1]
    end
    return [arr[y1][x1], x1,y1]
  end

  def testMove
    letter,x,y= move(@data, 0,0,[1,2])
    puts "Letter: #{letter} at: #{x} #{y}"
  end

  def part1
    def directions
      [
        [1, 1],
        [1, 0],
        [1, -1],
        [0, 1],
        [0, -1],
        [-1, 1],
        [-1, 0],
        [-1, -1],
      ]
    end

    puts "Part 1"
    puts "Question: howman times does XMAS appear in the data forwards, backwards, up, down, and diagonally?"

    xmas = "XMAS".split("")
    count = 0

    @data.each_with_index do |line, y|
      line.each_with_index do |letter,x|
        # x and y should be the coordinates of the letter in the string
        # if the letter is X look in every Direction for M
        directions.each do |direction|
          curLetter = letter
          curX,curY = x,y
          xmas.each do |testLetter|
            break unless curLetter === testLetter
            if curLetter === 'S'
              count+=1
            end
            curLetter,curX,curY = move(@data,curX,curY,direction)
          end
        end
      end
    end
    puts "Count: #{count}"
  end

  def part2
    def directions
      [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
      ]
    end

    puts "Part 2"
    puts "Question: its X-MAS!"

    mas = "MAS".split("")
    mases = []



    @data.each_with_index do |line, y|
      line.each_with_index do |letter,x|
        # x and y should be the coordinates of the letter in the string
        # if the letter is X look in every Direction for M
        directions.each do |direction|
          curLetter = letter
          curX,curY = x,y
          mas.each do |testLetter|
            break unless curLetter === testLetter
            if curLetter === 'S'
              aPos = move(@data,curX,curY,direction.map{|x| x*-1})
              mases.push([aPos[1],aPos[2]])
            end
            curLetter,curX,curY = move(@data,curX,curY,direction)
          end
        end
      end
    end

    # find the count of all mases that are the same
    count = 0
    mases.each do |mas|
      mases.count(mas) > 1 ? count+=1 : nil
    end

    puts("Count: #{count/2}")

  end
end

Solution.new
