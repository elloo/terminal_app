module Helpers
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

    def track_day
        # TD: Knowing that .open returns the block and .write returns length
        # TD: Getting the initial date to reset appropriately
        # TD: Getting the correct time to use in subtraction
        unless File.exists?('init.txt')
            @init_txt = File.open('init.txt', 'w+') { |f| f.write Date.today }
        end
    
        init_time = File.birthtime('init.txt')
        init_date = init_time.to_i / (60 * 60 * 24)
        # Add to current date to test day tracking function
        current_date = Time.now.utc.to_i / (60 * 60 * 24)
        
        day_num = current_date - init_date
        if day_num.nil? || day_num >= 100 || day_num < 0
            day_num = 0
        end
        @day = format('%02d', day_num)
        @day_index = @day.to_s.split(//)
    end
end