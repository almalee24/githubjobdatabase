class Position

    @@all = []

    attr_accessor :type, :company, :location, :title, :description, :url

    def initialize(position)
        @title = position[:title]
        @url = position[:url]
        @company = position[:company]
        @location = position[:location]
        @description = position[:description] 
        @@all << self
    end

    def self.all
        @@all 
    end
end