class Menu
    def initialize(num1, num2)
        @grid = []
        @day_index = 0
        track_day
        menu(num1, num2)
    end

    def menu(num1, num2)
        # Reset to create marks.txt and init.txt files
        unless File.exists?('marks.txt')
            reset
        end
        system "clear"
        # Read file to get latest version of marks in 2D array (@grid)
        read_file

        # TTY-Box syntax to create border with marks printed inside
        @box = TTY::Box.frame(width: 20, height: 12, title: {top_left: "Don\'t Break", bottom_right: 'the Chain'}, align: :center) {
    "#{@grid.join("\n")}"
    }
        puts @box

        # @day used from track_day method in helpers.rb
        puts "Day #{@day}"
            @menu = [
                {"Mark" => -> { 
                    # puts "num1 is  #{num1}" 
                    # puts  "num2 is  #{num2}"
                mark(num1, num2){@grid[num1][num2] = "x"} }},
                {"Delete" => -> { mark(num1, num2){@grid[num2][num1] = " "} }},
                {"Reset" => -> { reset }},
                {"Quit" => -> { # Problem: Sometimes needs quitting twice
                    system "clear" 
                    break }}]
        prompt = TTY::Prompt.new
        function = prompt.select("", @menu)
    end

    def mark(x, y)
        read_file
        # puts " x is #{x}" 
        # print "y is #{y}"
        # Using yield saves the creation of an extra delete method
        yield(x, y)
        write_file
        menu(@day_index[0].to_i, @day_index[1].to_i)
    end
    
    def reset
        # Delete init.txt as track_day relies on creation date
        if File.exists?('init.txt')
            File.delete('init.txt')
            @init_txt = nil
            track_day
        end

        # Start count to keep track of arrays pushed to @grid array
        count = 0
        # reinitialize the grid to empty upon reset and update array from 0-9
        # Using @grid to form a 2D array. This makes it easy to assign a day to a specific "x" mark. e.g. Day 00 could easily be turned into day_index[0]. day_index[0]
        @grid = []
        while count < 10
            # fixed_array from helpers.rb to create arrays with ten blank elements
            @grid.push(fixed_array(10, [""]).join(" "))
            count += 1
        end
        # Saving the empty 2D array to marks.txt
        write_file
        # Using @day_index array from track_day method in helpers.rb
        menu(@day_index[0].to_i, @day_index[1].to_i)
    end
end