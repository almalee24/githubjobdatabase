class API
    def self.positions_description(position)
        resp = RestClient.get("https://jobs.github.com/positions.json?search=" + position)
        pos_hash = JSON.parse(resp.body, symbolize_names:true)
        pos_hash.collect {|position| Position.new(position) }
        
    end

   def self.position_location(position)
        arr = position.split(" ")
        arr.length > 1 ? arr = position.split(" ").join("+") : arr = position
        resp = RestClient.get("https://jobs.github.com/positions.json?location=" + arr)
        pos_hash = JSON.parse(resp.body, symbolize_names:true)
        pos_hash.collect {|position| Position.new(position) }
   end
end