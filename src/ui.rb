class Menu
    def initialize(num1, num2)
        @grid = []
        @day_index = 0
        track_day
        menu(num1, num2)
    end

    def menu(num1, num2)
        unless File.exists?('marks.txt')
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
                {"Mark" => -> { 
                    puts "num1 is  #{num1}" 
                    puts  "num2 is  #{num2}"
                mark(num1, num2){@grid[num1][num2] = "x"} }},
                {"Delete" => -> { mark(num1, num2){@grid[num2][num1] = " "} }},
                {"Reset" => -> { reset }},
                {"Quit" => -> { # TD: Sometimes quitting twice
                    system "clear" 
                    break }}]
        prompt = TTY::Prompt.new
        function = prompt.select("", @menu)
    end

    def mark(x, y)
        read_file
        puts " x is #{x}" 
        print "y is #{y}"
        yield(x, y)
        write_file
        menu(@day_index[0].to_i, @day_index[1].to_i)
    end
    
    def reset
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
end