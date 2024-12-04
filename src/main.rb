# an entry point to run a given day's solution or to run all solutions

day_to_run = ARGV[0]

if day_to_run.nil?
  puts "Please provide a day to run."
  exit
end

puts "Running solution for day #{day_to_run}"

  solution_file = "2024/#{day_to_run}/solution.rb"

  if File.exist?(File.join(File.dirname(__FILE__), solution_file))
    require_relative solution_file
  else
    puts "Solution file does not exist for day #{day_to_run}"
    puts "Please create a solution file at #{solution_file}"
  end
