require "tty-box"
require "tty-prompt"
require "date"

@grid = []

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
    unless File.exist?('marks.txt')
        reset
    end
    # system "clear"
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

def day_num
    
    @init_txt = File.open('init.txt', 'w+') { Date.today }
    puts @day_num.class
    if @day_num.nil? || @day_num > 100
        @day_num = 0
    end
    @day_num = (Date.parse('20190506') - @init_txt).to_i
    @day = format('%02d', @day_num)
    @day.to_s.split(//)
end

@day_index = day_num
menu(@day_index[0].to_i, @day_index[1].to_i)