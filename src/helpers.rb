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
end