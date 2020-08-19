#CLI Controller 
require 'json'
require 'uri'
require 'net/http'
require 'openssl'
require 'colorize'
class Cards::CLI

SET_NAME = ["Basic", "Classic", "Reward", "Hall of Fame", "Curse of Naxxramas", "Goblins vs. Gnomes", "Blackrock Mountain", "The Grand Tournament", "League of Explorers", "Whispers of the Old Gods", "One Night in Karazhan", "Mean Streets of Gadgetzan", "Journey to Un'Goro", "Knights of the Frozen Throne", "Kobolds & Catacombs", "The Witchwood", "The Boomsday Project", "Rastakhan's Rumble", "Rise of Shadows", "Saviors of Uldum", "Descent of Dragons", "Galakrond's Awakening", "Demon Hunter Initiate", "Ashes of Outland", "Scholomance Academy"]

#display all of the set names
def call
    system('cls')
    puts "Welcome To The Hearthstone Card Sorter! To begin select a card set below:".green
    puts 
    puts "Card Sets: ".red
    puts 
    SET_NAME.each do |set|
    puts set.yellow
    end 
    #accept a user input of a card name from the set
    puts
    puts "----->  Please Select A Card Set  <-----".green
    user_input = gets.chomp #everything right of the = to line 31 can be refactored into its own method replacing gets.chomp with everything else 
    until SET_NAME.any? { |set| set == user_input}
        puts "Wrong Answer, Try Again"
        user_input = gets.chomp
    end 
    if user_input.include?(" ")
        user_input = user_input.gsub! " ", '%2520'
    end 
  
     
    system('cls')
    url = URI("https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/sets/#{user_input}")
    #search the results for that set object and display the set info
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'omgvamp-hearthstone-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = '092021095cmsh932130187e45668p1af4a3jsn70d602cd5550'
    
    response = http.request(request)
    result = JSON.parse(response.body)
    #display all of the result card names
    puts "Card Names:".red
    puts 
    result.each do |card|
    puts card["name"].yellow
    end
    #accept a user input of a card name from the set
    puts 
    puts "----->  Please Select A Card  <-----".green
    user_input = gets.chomp
    until result.any? { |card| card["name"] == user_input}
        puts "Wrong Answer, Try Again"
        user_input = gets.chomp
    end
    if user_input.include?(" ")
        user_input = user_input.gsub! " ", '%2520'
    end 
   
    system('cls')
    url = URI("https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/#{user_input}")
    #search the results for that card object and display the card info
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'omgvamp-hearthstone-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = '092021095cmsh932130187e45668p1af4a3jsn70d602cd5550'
    
    response = http.request(request)
    result = JSON.parse(response.body)
    puts "Card Information:".red
    puts 
    puts "Name = ".green + result[0]["name"].to_s.yellow
    puts "Card ID = ".green + result[0]["cardId"].to_s.yellow
    puts "Card Set = ".green + result[0]["cardSet"].to_s.yellow
    puts "Type = ".green + result[0]["type"].to_s.yellow
    puts "Rarity = ".green + result[0]["rarity"].to_s.yellow
    puts "Cost = ".green + result[0]["cost"].to_s.yellow
    puts "Attack = ".green + result[0]["attack"].to_s.yellow
    puts "Health = ".green + result[0]["health"].to_s.yellow
    puts "Text = ".green + result[0]["text"].to_s.yellow
    puts "Flavor Text = ".green + result[0]["flavor"].to_s.yellow
    puts "Artist = ".green + result[0]["artist"].to_s.yellow
    puts "Collectible? = ".green + result[0]["collectible"].to_s.yellow
    puts "Race = ".green + result[0]["race"].to_s.yellow
    puts "Image = ".green + result[0]["imgGold"].to_s.yellow
    puts 
    puts "Would you like to search again? (y/n)".red

    user_input = gets.chomp
    until user_input == "y" || user_input == "n"
        puts "Wrong Answer, Try Again"
        user_input = gets.chomp
    end 
    if user_input == "y"
        call 
    elsif user_input == "n"
        puts "Goodbye"
        return
    
    end 
end 
    

     
    
  
    
    
end 

