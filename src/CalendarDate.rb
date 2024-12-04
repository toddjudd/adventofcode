# write a class that can be extended by a soloution.rb
# the class should provide methods to: getData, submitSoloution, ReadData
require 'dotenv'
Dotenv.load

require 'faraday'

class CalendarDate
  attr_accessor :data, :day

  def initialize(day)
    @day = day
    @data = nil
    @caller_dir = File.dirname(caller_locations[1].path)

    getData
  end

  def getData
    # check if the data file exists
    if File.exist?(File.join( @caller_dir , 'data.txt'))
      @data = File.read(File.join( @caller_dir , 'data.txt'))
      puts "Data is Empty" if @data.empty?
      return unless @data.empty?
    end

    # make and api call to get the input data
    url = "https://adventofcode.com/2024/day/#{@day}/input"
    token = ENV['AOC_SESSION_COOKIE']
    headers = {
      'Cookie' => 'session=53616c7465645f5fabf99474080499a843fe99a255749de53faf52ba2ff43bf65b8e7e193881b2a49f795edd7b2000e431e7885a998bb36addf6d0c5fa417dcf'
    }

    puts "Getting data from: #{url}"
    puts "Using token: #{token}"
    request = Faraday.get(url) do |req|
      req.headers['Cookie'] = "session=#{token}"
    end
    @data = request.body
    # write the data to data.txt file
    File.open(File.join( @caller_dir , 'data.txt'), 'w') { |file| file.write(@data) }
  end

  def submitSolution(solution)
    raise "Submit Soloution has not been implimented"
  end

  def readData
    File.read(File.join( @caller_dir , 'data.txt'))
  end
end
