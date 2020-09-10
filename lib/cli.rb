class CLI
    
    def run
        puts "Welcome to the Job Database!"
        puts "There are so many positons and can be a bit overwhelming, how about we narrow it down!"
        # API.positions
        menu
    end

    def list_position
        Position.all.each.with_index(1) { | position, i | puts "#{i}. #{position.title}" }
    end

    def display_position_details(position)
        puts ""
        puts "Here are the details for #{position.title}:"
        puts ""
        puts "COMPANY: #{position.company}"
        puts ""
        puts "LOCATION: #{position.location}"
        puts ""
        puts "DESCRIPTION: #{Nokogiri::HTML(position.description).xpath("//text()").text.gsub("Description", "")}"  
    end

    def menu
        puts "Type 'location' or 'description' to narrow down your search."
        puts ""

        input = gets.strip.downcase
        if input == 'location'
            puts ""
            puts "Input an area."
            puts ""
            puts "1. North America"
            puts "2. South America"
            puts "3. Europe"
            puts "4. Asia"
            puts "5. Australia"
            puts ""
            
            term = gets.strip.downcase
            API.position_location("#{term}")
            list_position
            puts ""
            puts "Please select a number to get the details."
            input = gets.chomp
            if !input.to_i.between?(1, Position.all.count)
                puts "Position not found. Please select a different position!"
                list_position
            else
                position = Position.all[input.to_i-1]
                display_position_details(position)
                add_cart(position)
                see_more
            end
            
        elsif input == 'description'
            puts "Input a language."
            puts ""
            puts "1. Javascript"
            puts "2. Node"
            puts "3. React"
            puts "4. Ruby"
            puts "5. Python"
            puts "6. Java"
            puts ""

            term = gets.strip.downcase
            API.positions_description(term)
            list_position

            puts ""
            puts "Please select a number to get the details."
            input = gets.chomp
            puts ""
            if !input.to_i.between?(1, Position.all.count)
                puts "Position not found. Please select a different position!"
                list_position
            else
                position = Position.all[input.to_i-1]
                display_position_details(position)
                add_cart(position)
                see_more
            end
        end
    end

    def see_more
        puts ""
        puts "Would you like to see more positions?"
        puts "Please enter Y or N"
        puts "To see your cart enter C"
        puts ""

        another_character = gets.strip.downcase
        if another_character == "y"
            menu
        elsif another_character == "n"
            exit
        elsif another_character == 'c'
            see_cart
        end
    end

    def add_cart(position)
        puts ""
        puts "Would you like to add this to your cart?"
        puts "Please enter Y or N"
        puts ""

        another_character = gets.strip.downcase
        if another_character == "y"
            Cart.new(position)
            see_more
        else 
            see_more
        end 
    end

    def list_cart
        Cart.all.each.with_index(1) { | position, i | puts "#{i}. #{position.title}" }
    end

    def see_cart()
        puts "Welcome to your cart!"
        list_cart
        puts ""
        puts "If you would like to apply for a position select a number."
        puts ""
        input = gets.chomp
        if !input.to_i.between?(1, Cart.all.count)
            puts "Position not found. Please select a different position!"
            list_cart
        else
            position = Cart.all[input.to_i-1]
            puts "To apply for #{position.title}."
            puts "Please go to the following url: #{position.url}"
            puts ""
            puts "Would you like to go back to the cart? Y or N"
            puts ""
            another_character = gets.strip.downcase
            if another_character == "y"
                list_cart
            else 
                see_more
            end
        end
    end

end