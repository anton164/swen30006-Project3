require 'open-uri'
require 'json'
require 'time'

scheduler = Rufus::Scheduler.new
parser = BOMParser.new
UPDATE_INTERVAL = '30m'

puts "Will parse from BOM every " + UPDATE_INTERVAL
scheduler.every(UPDATE_INTERVAL, :first_in => 0.5) do
  puts "Parsing from BOM..."
  parser.parse_measurements
  puts "Successfully parsed measurements from BOM"
end
