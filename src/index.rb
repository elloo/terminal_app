require "tty-box"
require "tty-prompt"
require "date"

@grid = []
@marks_txt = false

# HELPER METHODS

def fixed_array(size, content)
    Array.new(size){|i| content[i]}
end

def read_file
    @grid = []
    File.open('marks.txt').readlines.each do |line|
        @grid << line
    end
end

def write_file
    File.open('marks.txt', 'w') { |f| f.puts(@grid)}
end

# MAIN METHODS

def menu(num2, num1 = 0)
    # If marks.txt file exists show box and menu, else reset
    if @marks_txt
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
    else
        reset
    end
end

def mark(y, x = 0)
    read_file
    @grid[x][y] = "x"
    write_file
    menu(@day_index[0].to_i, @day_index[1].to_i)
end

def delete(y, x=0)
    read_file
    @grid[x][y] = " "
    write_file
    menu(@day_index[0].to_i, @day_index[1].to_i)
end

def reset

    @init_date = Date.today
    init_txt = File.open('init.txt', 'w') { |f| f.write (@init_date)}
    @day_num = (Date.today - Date.parse("#{init_txt}")).to_i

    count = 0
    # reinitialize the grid to empty upon reset and update array from 0-9
    @grid = []
    while count < 10
        @grid.push(fixed_array(10, [""]).join(" "))
        count += 1
    end
    write_file
    @marks_txt = true

    menu(@day_index[0].to_i, @day_index[1].to_i)
end
# Testing above else condition for determining @day_num
# @day_num = (Date.today - Date.new(2019,4,4)).to_i

if @day_num == nil
    @day_num = 0
elsif @day_num > 100
    reset
end
@day = format('%02d', @day_num)
@day_index = @day.to_s.split(//)
menu(@day_index[0].to_i, @day_index[1].to_i)