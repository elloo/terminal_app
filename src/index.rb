require "tty-box"
require "tty-prompt"
require "date"
require_relative "helpers"
require_relative "ui"

include Helpers 

track_day
start_app = Menu.new(@day_index[0].to_i, @day_index[1].to_i)
