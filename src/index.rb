require "tty-box"
require "tty-prompt"
require "date"
require_relative "helpers"

@grid = []
@day_index = 0

# MAIN METHODS

def menu(num2, num1 = 0)
    include Helpers
    unless File.exists?('marks.txt')
        reset
    end
    system "clear"
    read_file
    @box = TTY::Box.frame(width: 20, height: 12, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center) {
"#{@grid.join("\n")}"
}
    puts @box

    puts "Day #{@day}"
        @menu = [
            {"Mark" => -> { mark(num1, num2) }},
            {"Delete" => -> { delete(num1, num2) }},
            {"Reset" => -> { reset }},
            {"Quit" => -> { 
                system "clear" 
                break }}]
    prompt = TTY::Prompt.new
    function = prompt.select("", @menu)
end

def mark(y, x = 0)
    include Helpers
    read_file
    @grid[x][y] = "x"
    write_file
    menu(@day_index[0].to_i, @day_index[1].to_i)
end

def delete(y, x=0)
    include Helpers
    read_file
    @grid[x][y] = " "
    write_file
    menu(@day_index[0].to_i, @day_index[1].to_i)
end

def reset
    include Helpers
    if File.exists?('init.txt')
        File.delete('init.txt')
        @init_txt = nil
        track_day
    end
    count = 0
    # reinitialize the grid to empty upon reset and update array from 0-9
    @grid = []
    while count < 10
        @grid.push(fixed_array(10, [""]).join(" "))
        count += 1
    end
    write_file
    menu(@day_index[0].to_i, @day_index[1].to_i)
end

def track_day
    # TD: Knowing that .open returns the block and .write returns length
    # TD: Getting the initial date to reset appropriately
    unless File.exists?('init.txt')
        @init_txt = File.open('init.txt', 'w+') { |f| f.write Date.today }
    end

    init_time = File.birthtime('init.txt')
    init_date = init_time.to_i / (60 * 60 * 24)
    current_date = Date.today.to_time.to_i / (60 * 60 * 24)
    
    day_num = current_date - init_date
    if day_num.nil? || day_num > 100 || day_num < 0
        day_num = 0
    end
    @day = format('%02d', day_num)
    @day_index = @day.to_s.split(//)
end

track_day
menu(@day_index[0].to_i, @day_index[1].to_i)