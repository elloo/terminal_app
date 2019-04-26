module Helpers
    
    # Used to create an array of ten blank elements.
    def fixed_array(size, content)
        Array.new(size){|i| content[i]}
    end

    # Creates a 2D array from the lines of marks contained in marks.txt
    def read_file
        @grid = []
        File.open('marks.txt').readlines.each do |line|
            @grid << line
        end
    end

    # Writes the marks stored in @grid to the marks.txt file
    def write_file
        File.open('marks.txt', 'w') { |f| f.puts(@grid)}
    end

    # Used to keep count of days 0 - 99. 
    # Keeping it coder themed by counting from 0
    def track_day

        # Create the init.txt file unless it already exists
        unless File.exists?('init.txt')
            @init_txt = File.open('init.txt', 'w+') { |f| f.write Date.today }
        end
    
        # Keep track of when the file was created
        init_time = File.birthtime('init.txt')
        # Convert the time of file creation into days
        init_date = init_time.to_i / (60 * 60 * 24)
        # Convert the current time into days
        # Note that Time.now had to be used instead of Date.today so that it could be subtracted by the File.birthtime
        # (Add to current date to test day tracking function)
        current_date = Time.now.utc.to_i / (60 * 60 * 24)
        
        # Calculate the current day by subtracting current_date from init_date
        day_num = current_date - init_date

        # In case of edge cases
        if day_num.nil? || day_num >= 100 || day_num < 0
            day_num = 0
        end

        # Making sure that single-digit numbers can be accepted
        @day = format('%02d', day_num)

        # Splitting numbers into two separate elements in an array
        @day_index = @day.to_s.split(//)
    end
end