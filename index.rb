require "tty-box"
require "tty-prompt"

def menu(num2, num1 = 0)
    system "clear"
    puts "What would you like to do?"
        @menu = [
            {"View" => -> { view }},
            {"Add" => -> { add(num1, num2) }},
            {"Delete" => -> { delete(num1, num2) }},
            {"Update" => -> { update }}]
    prompt = TTY::Prompt.new
    function = prompt.select("", @menu)
end

count = 0
@grid = []

def fixed_array(size, content)
    Array.new(size){|i| content[i]}
end

while count < 10
    @grid.push(fixed_array(10, [count]).join(" "))
    count += 1
end

@box = TTY::Box.frame(width: 20, height: 14, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center, padding: 1) {
"#{@grid.join("\n")}"
}

def view
    puts @box
end

def add(y, x = 0)
    @grid[x][y] = "x"
    @box = TTY::Box.frame(width: 20, height: 14, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center, padding: 1) {
"#{@grid.join("\n")}"
}
    puts @box
end

def delete(y, x=0)
    @grid[x][y] = " "
    @box = TTY::Box.frame(width: 20, height: 14, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center, padding: 1) {
"#{@grid.join("\n")}"
}
    puts @box
end

day = 0.to_s.split(//)
menu(day[0].to_i, day[1].to_i)