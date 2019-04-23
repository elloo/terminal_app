require "tty-box"

grid = []
count = 0

def fixed_array(size, content)
    Array.new(size){|i| content[i]}
end

while count < 10
    grid.push(fixed_array(10, [count]).join(" "))
    count += 1
end

grid[0][5] = "x"

box = TTY::Box.frame(width: 20, height: 14, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center, padding: 1) {
"#{grid.join("\n")}"
}
puts box