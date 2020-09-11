class CLI
        $select_job = 0
        $location_selected = 'nowhere'
        $description_selected = "none"
        $languages = ["Javascript", "Node", "Ruby", "Python", "Java"]
        $locations = ["North America", "South America", "Europe", "Africa", "Asia", "Australia"]
        $list = 'no'
 
    
    def run 
        puts "▒█░░▒█ █▀▀ █░░ █▀▀ █▀▀█ █▀▄▀█ █▀▀ 　 ▀▀█▀▀ █▀▀█ 　 ▒█▀▀█ ░▀░ ▀▀█▀▀ █░░█ █░░█ █▀▀▄ 　 ░░░▒█ █▀▀█ █▀▀▄ █▀▀ █".colorize(:light_blue)
        puts "▒█▒█▒█ █▀▀ █░░ █░░ █░░█ █░▀░█ █▀▀ 　 ░░█░░ █░░█ 　 ▒█░▄▄ ▀█▀ ░░█░░ █▀▀█ █░░█ █▀▀▄ 　 ░▄░▒█ █░░█ █▀▀▄ ▀▀█ ▀".colorize(:light_blue)
        puts "▒█▄▀▄█ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀░░░▀ ▀▀▀ 　 ░░▀░░ ▀▀▀▀ 　 ▒█▄▄█ ▀▀▀ ░░▀░░ ▀░░▀ ░▀▀▀ ▀▀▀░ 　 ▒█▄▄█ ▀▀▀▀ ▀▀▀░ ▀▀▀ ▄".colorize(:light_blue)
        puts ""
        puts "          There are so many positions and can be overwhelming. How about we narrow it down!"
        menu
    end

    def menu
        puts "                        Type 'location' or 'description' to narrow down your search."
        puts ""

        input = gets.strip.downcase
        
        if input == "location"
            location_paramater
        elsif input == "description"
            description_parameter
        else
            puts "Wrong input, try again!".colorize(:red)
            menu
        end

        display_position_details
        add_cart
        see_more
    end

    def location_paramater
        puts ""
        puts"▀█▀ █▀▀▄ █▀▀█ █░░█ ▀▀█▀▀ 　 █▀▀█ 　 █░░ █▀▀█ █▀▀ █▀▀█ ▀▀█▀▀ ░▀░ █▀▀█ █▀▀▄ ░".colorize(:light_blue)
        puts"▒█░ █░░█ █░░█ █░░█ ░░█░░ 　 █▄▄█ 　 █░░ █░░█ █░░ █▄▄█ ░░█░░ ▀█▀ █░░█ █░░█ ▄".colorize(:light_blue)
        puts"▄█▄ ▀░░▀ █▀▀▀ ░▀▀▀ ░░▀░░ 　 ▀░░▀ 　 ▀▀▀ ▀▀▀▀ ▀▀▀ ▀░░▀ ░░▀░░ ▀▀▀ ▀▀▀▀ ▀░░▀ █".colorize(:light_blue)
        puts""
        $locations.collect.with_index(1) { | location, i | puts "#{i}. #{location}" }
        puts ""

        $location_selected = gets.strip.split.map(&:capitalize).join(' ')
        binding.pry
        if $locations.include?($location_selected) 
            $list = API.position_location($location_selected)
            list_position
        else
            puts "Wrong input, Try again!".colorize(:red)
            location_paramater
        end
    end

    def  description_parameter
        puts ""
        puts "▀█▀ █▀▀▄ █▀▀█ █░░█ ▀▀█▀▀ 　 █▀▀█ 　 █░░ █▀▀█ █▀▀▄ █▀▀▀ █░░█ █▀▀█ █▀▀▀ █▀▀ ░".colorize(:light_blue)
        puts "▒█░ █░░█ █░░█ █░░█ ░░█░░ 　 █▄▄█ 　 █░░ █▄▄█ █░░█ █░▀█ █░░█ █▄▄█ █░▀█ █▀▀ ▄ ".colorize(:light_blue)
        puts "▄█▄ ▀░░▀ █▀▀▀ ░▀▀▀ ░░▀░░ 　 ▀░░▀ 　 ▀▀▀ ▀░░▀ ▀░░▀ ▀▀▀▀ ░▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ █".colorize(:light_blue)
        puts ""
        $languages.each.with_index(1) { | language, i | puts "#{i}. #{language}" }
        puts ""

        $description_selected = gets.strip.capitalize!
        if $languages.include?($description_selected) 
            $list = API.positions_description($description_selected)
            list_position
        else
            puts ""
            puts "Wrong input!".colorize(:red)
            description_parameter
        end
    end

    def list_position
        binding.pry
        if $list == [] && $location_selected == 'nowhere'
            puts "Seems like there is no #{$description_selected} positions. Try Again!".colorize(:red)
            description_parameter
        elsif $list == [] && $description_selected = "none"
            puts "Seems like there is no positions in #{$location_selected.capitalize!}. Try Again!".colorize(:red)
            location_paramater
        end

        puts ""
        puts"▒█▀▀▀█ █▀▀ █░░ █▀▀ █▀▀ ▀▀█▀▀ 　 █▀▀█ 　 █▀▀▄ █░░█ █▀▄▀█ █▀▀▄ █▀▀ █▀▀█ ░".colorize(:light_blue)
        puts"░▀▀▀▄▄ █▀▀ █░░ █▀▀ █░░ ░░█░░ 　 █▄▄█ 　 █░░█ █░░█ █░▀░█ █▀▀▄ █▀▀ █▄▄▀ ▄".colorize(:light_blue)
        puts"▒█▄▄▄█ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀ ░░▀░░ 　 ▀░░▀ 　 ▀░░▀ ░▀▀▀ ▀░░░▀ ▀▀▀░ ▀▀▀ ▀░▀▀ █".colorize(:light_blue)
        puts ""
        $list.each.with_index(1) { | position, i | puts "#{i}. #{position.title}" }
        puts""

        input = gets.chomp

        if !input.to_i.between?(1, $list.count)
            puts "Position not found. Please select a different position!".colorize(:red)
            list_position
        else
            $select_job = $list[input.to_i-1]
        end
    end

    def display_position_details
        puts ""
        puts "Here are the details for #{$select_job.title}:".colorize(:light_blue)
        puts ""
        puts "COMPANY: #{$select_job.company}"
        puts ""
        puts "LOCATION: #{$select_job.location}"
        puts ""
        puts "DESCRIPTION: #{Nokogiri::HTML($select_job.description).xpath("//text()").text.gsub("Description", "")}" 
    end


    def see_more
        puts ""
        puts "Would you like to see more positions? Enter Y or N".colorize(:light_cyan)
        puts "Enter C for cart.".colorize(:light_cyan)
        puts ""

        another_character = gets.strip.downcase
        if another_character == "y"
            menu
        elsif another_character == "n"
            puts"▀▀█▀▀ █░░█ █▀▀█ █▀▀▄ █░█ 　 █░░█ █▀▀█ █░░█ 　 █▀▀ █▀▀█ █▀▀█ 　 █▀▀ █░█ █▀▀█ █░░ █▀▀█ █▀▀█ ░▀░ █▀▀▄ █▀▀▀".colorize(:blue)
            puts"░▒█░░ █▀▀█ █▄▄█ █░░█ █▀▄ 　 █▄▄█ █░░█ █░░█ 　 █▀▀ █░░█ █▄▄▀ 　 █▀▀ ▄▀▄ █░░█ █░░ █░░█ █▄▄▀ ▀█▀ █░░█ █░▀█".colorize(:blue) 
            puts"░▒█░░ ▀░░▀ ▀░░▀ ▀░░▀ ▀░▀ 　 ▄▄▄█ ▀▀▀▀ ░▀▀▀ 　 ▀░░ ▀▀▀▀ ▀░▀▀ 　 ▀▀▀ ▀░▀ █▀▀▀ ▀▀▀ ▀▀▀▀ ▀░▀▀ ▀▀▀ ▀░░▀ ▀▀▀▀".colorize(:blue)
            puts""
            puts"▒█▀▀█ ░▀░ ▀▀█▀▀ ▒█░▒█ █░░█ █▀▀▄ 　 ░░░▒█ █▀▀█ █▀▀▄ █▀▀ █ 　 ▒█▀▀▀█ █▀▀ █▀▀ 　 █░░█ █▀▀█ █░░█ 　 █▀▀▄ █▀▀ █░█ ▀▀█▀▀".colorize(:blue)
            puts"▒█░▄▄ ▀█▀ ░░█░░ ▒█▀▀█ █░░█ █▀▀▄ 　 ░▄░▒█ █░░█ █▀▀▄ ▀▀█ ▀ 　 ░▀▀▀▄▄ █▀▀ █▀▀ 　 █▄▄█ █░░█ █░░█ 　 █░░█ █▀▀ ▄▀▄ ░░█░░".colorize(:blue)
            puts"▒█▄▄█ ▀▀▀ ░░▀░░ ▒█░▒█ ░▀▀▀ ▀▀▀░ 　 ▒█▄▄█ ▀▀▀▀ ▀▀▀░ ▀▀▀ ▄ 　 ▒█▄▄▄█ ▀▀▀ ▀▀▀ 　 ▄▄▄█ ▀▀▀▀ ░▀▀▀ 　 ▀░░▀ ▀▀▀ ▀░▀ ░░▀░░".colorize(:blue)
            puts""
            puts"▀▀█▀▀ ░▀░ █▀▄▀█ █▀▀ █".colorize(:blue)
            puts"░░█░░ ▀█▀ █░▀░█ █▀▀ ▀".colorize(:blue)
            puts"░░▀░░ ▀▀▀ ▀░░░▀ ▀▀▀ ▄".colorize(:blue)
            exit
        elsif another_character == 'c'
            see_cart
        else 
            puts "Wrong input try again!".colorize(:red)
            see_more
        end
    end

    def add_cart
        puts ""
        puts "Would you like to add this to your cart? Enter Y or N".colorize(:light_cyan)
        puts ""

        another_character = gets.strip.downcase
        if another_character == "y"
            Cart.new($select_job)
            see_more
        elsif another_character == "n"
            see_more
        else 
            puts "Wrong input try again!".colorize(:red)
            add_cart
        end 
    end

    def see_cart
        puts ""     
        puts "▒█░░▒█ █▀▀ █░░ █▀▀ █▀▀█ █▀▄▀█ █▀▀ 　 ▀▀█▀▀ █▀▀█ 　 █░░█ █▀▀█ █░░█ █▀▀█ 　 █▀▀ █▀▀█ █▀▀█ ▀▀█▀▀ █".colorize(:light_blue)
        puts "▒█▒█▒█ █▀▀ █░░ █░░ █░░█ █░▀░█ █▀▀ 　 ░░█░░ █░░█ 　 █▄▄█ █░░█ █░░█ █▄▄▀ 　 █░░ █▄▄█ █▄▄▀ ░░█░░ ▀".colorize(:light_blue)
        puts "▒█▄▀▄█ ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀░░░▀ ▀▀▀ 　 ░░▀░░ ▀▀▀▀ 　 ▄▄▄█ ▀▀▀▀ ░▀▀▀ ▀░▀▀ 　 ▀▀▀ ▀░░▀ ▀░▀▀ ░░▀░░ ▄".colorize(:light_blue)
        puts""
        list_cart = Cart.all.each.with_index(1) { | position, i | puts "#{i}. #{position.title}" }
        puts ""
        puts "If you would like to apply for a position select a number. To go back to menu type M.".colorize(:light_cyan)
        puts ""

        input = gets.chomp
        if input.downcase == "m"
            menu
        elsif !input.to_i.between?(1, Cart.all.count)
            puts "Position not found. Please select a different position!".colorize(:red)
            see_cart
        else
            position = Cart.all[input.to_i-1]
            puts "To apply for #{position.title}."
            puts ""
            doc = Nokogiri::HTML(open(position.url))
            doc.css("div.highlighted div.inner").each { |position| puts "Use this URL: #{position.css('a').attr('href').value}" }

            puts ""
            puts "Would you like to go back to the cart? Y or N".colorize(:light_cyan)
            puts ""
            another_character = gets.strip.downcase
            if another_character == "y"
                see_cart
            elsif another_character == "n" 
                see_more
            else 
                puts "Wrong input, try again!".colorize(:red)
            end
        end
    end

end