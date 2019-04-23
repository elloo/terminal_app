require "tty-box"

box = TTY::Box.frame(width: 30, height: 14, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center, padding: 1) do
"xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx
xxxxxxxxxx"
end
print box