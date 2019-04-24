require "tty-box"
require "tty-prompt"

def menu(num2, num1 = 0)
    system "clear"
    puts "What would you like to do?"
        @menu = [
            {"View" => -> { view }},
            {"Add" => -> { add(num1, num2) }},
            {"Delete" => -> { delete(num1, num2) }},
            {"Reset" => -> { reset }}]
    prompt = TTY::Prompt.new
    function = prompt.select("", @menu)
end

@grid = []

# HELPER METHODS

def fixed_array(size, content)
    Array.new(size){|i| content[i]}
end

def read_file
    File.open('marks1.txt').readlines.each do |line|
        @grid << line
    end
end

def write_file
    File.open('marks1.txt', 'w') { |f| f.puts(@grid)}
end

# MAIN METHODS

def view
    # @array = []
    read_file
    @box = TTY::Box.frame(width: 20, height: 12, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center) {
"#{@grid.join("\n")}"
}
    puts @box
end

def add(y, x = 0)
    read_file
    @grid[x][y] = "x"
    write_file
    view
end

def delete(y, x=0)
    read_file
    @grid[x][y] = " "
    write_file
    view
end

def reset
    count = 0
    # reinitialize the grid to empty upon reset and update array from 0-9
    @grid = []
    while count < 10
        @grid.push(fixed_array(10, [count]).join(" "))
        count += 1
    end
    write_file
    menu(0)
end

test = 1
day = test.to_s.split(//)
menu(day[1].to_i, day[0].to_i)