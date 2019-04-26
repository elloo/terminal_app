require "tty-box"
require "tty-prompt"
require "date"
require_relative "helpers"
require_relative "ui"

include Helpers 

# Begins method for counting days that have passed since last reset
# THis is used for @day_index when instantiating the Menu
track_day

# puts "First day digit: #{day_index[0]}"
# puts "Second day digit: #{day_index[1]}"

# Returns an instance of the UI
start_app = Menu.new(@day_index[0].to_i, @day_index[1].to_i)
