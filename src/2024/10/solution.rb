require_relative '../../CalendarDate.rb'

class Directions
  class << self
    def up
      [0,-1]
    end
    def down
      [0,1]
    end
    def left
      [-1,0]
    end
    def right
      [1,0]
    end

    def all
      [
        self.up,
        self.right,
        self.down,
        self.left,
      ]
    end

    def lookupString(direction)
      case direction
      when self.up
        return "up"
      when self.down
        return "down"
      when self.left
        return "left"
      when self.right
        return "right"
      else
        return "unknown"
      end
    end
  end
end

class Solution < CalendarDate
  def initialize
    super(10)

#     @data = "
# 89010123
# 78121874
# 87430965
# 96549874
# 45678903
# 32019012
# 01329801
# 10456732"

    @data = @data.strip!.split("\n").map {|x| x.split('').map { |y| y.to_i}} # map data

    @paths = {}

    puts "Data: #{@data}"

    @trailheads = searchMap(0)
    @peaks = searchMap(9)

    puts "Trailheads: #{@trailheads}"
    puts "Peaks: #{@peaks}"

    # trailhead = @trailheads[4]
    #   puts "Trailhead: #{trailhead}"
    #   blaze(trailhead, 0, trailhead)
    #   puts "Paths: #{@paths[trailhead.to_s]}"
    #   puts "uniqPaths #{@paths[trailhead.to_s].uniq.count}"
    #   puts "totalPaths #{@paths[trailhead.to_s].count}"


    @trailheads.each do |trailhead|
      puts "Trailhead: #{trailhead}"
      blaze(trailhead, 0, trailhead)
      puts "uniqPaths #{@paths[trailhead.to_s].uniq.count}"
      puts "totalPaths #{@paths[trailhead.to_s].count}"
    end

    uniqPathSum = 0
    totalPathSum = 0
    @paths.each do |key, value|
      uniqPathSum += value.uniq.count
      totalPathSum += value.count
    end

    puts "uniq Paths: #{uniqPathSum}"
    puts "total Paths: #{totalPathSum}"


  end

  def move(x,y,direction)
    xd = direction[0]
    yd = direction[1]

    x1 = x + xd
    y1 = y + yd

    if x1 < 0 || y1 < 0 || x1 > @data.length-1 || y1 > @data[x1].length-1
      return [-1,-1,-1]
    end
    return [@data[y1][x1], x1,y1]
  end

  def searchMap(query)
        points = []
    @data.each_with_index do |row, y|
      row.each_with_index do |value, x|
        points << [x,y] if value == query
      end
    end
    return points
  end

  def blaze(point, value, trailhead)
    # puts "Blazing from #{point[0]}, #{point[1]} Current Value: #{value}"
    x,y = point[0],point[1]

    Directions.all.each do |direction|
      if value == 9
        if @paths[trailhead.to_s]
          @paths[trailhead.to_s] << point.to_s
          return
        end
        @paths[trailhead.to_s] =[point.to_s]
        return
      end
      neighbor = move(x,y,direction)
      if neighbor[0] == value+1
        # puts "Neighbor #{Directions.lookupString(direction)}"
        blaze([neighbor[1],neighbor[2]], value+1, trailhead)
      end
    end
  end


end

Solution.new
