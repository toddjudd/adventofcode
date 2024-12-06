require_relative '../../CalendarDate.rb'
require 'pry'

class Directions
  def initialize
    @self = {
      up: ['^', [0,-1]],
      down: ['v', [0,1]],
      left: ['<', [-1,0]],
      right: ['>', [1,0]],
    }
  end

  def strings
    @self.values.map {|x| x[0]}
  end

  def as_array
    @self.values.map {|x| x[1]}
  end

  def as_hash
    @self
  end

  def names
    @self.keys
  end

  def rotate_right(direction)
    case direction[0]
    when "^"
      return @self[:right]
    when ">"
      return @self[:down]
    when "v"
      return @self[:left]
    when "<"
      return @self[:up]
    end
  end

end

class Map
  attr_accessor :curPos, :curDirection, :data, :on_map, :crossing, :new_obstacles
  def initialize(data)
    @data = data.split("\n").map do |line|
      line.split("")
    end
    @on_map = true
    @crossing = false
    @new_obstacles = [] # [x,y]
  end

  def pretty_print

    copy = Marshal.load( Marshal.dump(@data) )

    copy.each_with_index do |line,y|
      line.each_with_index do |item, x|
        if @new_obstacles.include?([x,y])
          line[x] = "O"
        end
      end
      puts line.join("")
    end
  end

  def flat
    @data.flatten.join("")
  end

  def directions
    Directions.new
  end

  def move(x,y,direction)
    xd = direction[0]
    yd = direction[1]

    x1 = x + xd
    y1 = y + yd

    if x1 < 0 || y1 < 0 || x1 > @data.length-1 || y1 > @data[x1].length-1
      return ["Z",-1,-1]
    end
    return [@data[y1][x1], x1,y1]
  end

  def curPos
    [
      @data[@data.index {|x| (x & directions.strings).any?}].index {|x| directions.strings.include?(x)},
      @data.index {|x| (x & directions.strings).any?}
    ]
  end

  def curDirection
    directions.names[directions.strings.index(@data[curPos[1]][curPos[0]])]
  end

  def curFacing
    move(curPos[0], curPos[1], directions.as_array[directions.names.index(curDirection)])
  end

  def get_right
   case curDirection
    when :up
      directions.as_hash[:right]
    when :right
      directions.as_hash[:down]
    when :down
      directions.as_hash[:left]
    when :left
      directions.as_hash[:up]
    end

  end


  def turn_right
    # puts "Turning from #{direction} to #{newDirection}"
    @data[curPos[1]][curPos[0]] = get_right[0]
  end

  def look_right
     move(curPos[0], curPos[1], get_right[1])
  end

  def look_right_distant?
    # puts "Get Right: #{get_right[1]}" # [1,0]

    right = look_right
    right_direction = get_right
    distance = 0

    while right[0] != "Z"
      if right[0] == "+"
        return true if move(right[1], right[2], right_direction[1])[0] == "#"
      end
      if right[0] == "#"
        right_direction = directions.rotate_right(right_direction)
      end
      right = move(right[1], right[2], right_direction[1])
      distance += 1
      print "\rDistance: #{distance} & Direction: #{right_direction}"
      return true if distance > 1000000
    end


    return false
  end

  def determine_trail
    if @crossing
      @crossing = false
      return "+"
    end
    if ["|","-"].include?curFacing[0]
      @crossing = true
    end
    case curDirection
    when :up, :down
      return "|"
    when :left, :right
      return "-"
    end
  end

  def valid_new_obstacle?
    # if right is a trail that bisects the current direction
    # then the current facing position is a valid looping obstacle

    return true if look_right[0] == "+"

    case curDirection
    when :up, :down
      return true if look_right[0] == "-"
    when :left, :right
      return true if look_right[0] == "|"
    end

    return false
  end

  def progress
    pos = curPos
    direction = curDirection

    facing = curFacing
    look_right
    @new_obstacles << facing[1..2] if look_right_distant?

    puts "Facing: #{facing}"
    puts "Look Right: #{look_right}"
    case facing[0]
    when ".","X","|","-","+"
      puts "Moving Forward"
      @data[pos[1]][pos[0]] = determine_trail
      @data[facing[2]][facing[1]] = directions.as_hash[direction][0]
    when "#"
      puts "Turning Right"
      # turn_right
      @data[look_right[2]][look_right[1]] = get_right[0]
      @data[pos[1]][pos[0]] = "+"
    when "Z"
      puts "End of Map"
      @on_map = false
    end
  end
end

class Solution < CalendarDate
  def initialize
    super(6)

#     @data =
# "....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#..."

    @map = Map.new(@data)
    puts @map
    i = 0

    while @map.on_map
      i +=1
      puts "Iteration: #{i}"
      puts "CurPos: #{@map.curPos[0]} #{@map.curPos[1]}"
      puts "CurDirection: #{@map.curDirection}"
      puts "Crossing: #{@map.crossing}"

      flatmap = @map.flat

      puts  "Possitions Passed: #{flatmap.count('X') + flatmap.count('+') + flatmap.count('|') + flatmap.count('-') +1}"
      puts "Possible Obstacles: #{@map.new_obstacles.count}"
      @map.progress
      system "clear"
      # @map.pretty_print
      # sleep(0.5)
      # require user input to continue

    end

    @map.pretty_print

  end
end

Solution.new
