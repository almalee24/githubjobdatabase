class Cart
    @@all = []

    def initialize(position)
        @@all << position 
    end

    def self.all
        @@all 
    end
end