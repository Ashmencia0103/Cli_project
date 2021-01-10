class Cli
    @@brand_array = ["honda", "hyundai", "toyota", "kia", "ford", "chevrolet", "jeep", "gmc", "subaru", "nissan"]
   

    def initialize 
        @@vehicle_list = [] 
        call
    end 

   
    def call  
        puts "Welcome to Zelayas Car Dealership!"
        puts ""
        puts "To see Vehicle Brand, enter '1' " 
        puts ""
        puts "To see your saved vehicle list enter '2' "
        puts ""
        puts "To exit Zelayas Car Dealership, enter 'Exit' "
        puts ""
        menu 
    end 

    def menu  
        input = gets.strip.downcase 
        if input == "1"
            system("clear") 
            vehicle_list
        elsif input == "2"
            view_vehicle_list
        elsif input.downcase == "exit"
           goodbye 
        else 
            invalid_entry
        end 
    end 

    def vehicle_list
       @@brand_array.each.with_index {|brand, index| puts "#{index + 1}. #{brand.capitalize}"} 

        puts ""
        puts ""
        puts "Which brand would you like details about, enter its number: "
        input = gets.strip.downcase
        system("clear") 
        vehicle_selection(input)
    end 

    def vehicle_selection(vehicle) 
        puts "You have selected #{@@brand_array[vehicle.to_i-1]}"
        puts ""
        puts "Please enter a year in 'XXXX' format"
        year = gets.strip
        make = @@brand_array[vehicle.to_i-1]
        system("clear") 
        #binding.pry
        response = Api.new(make, year).parse_json
        results = response["Results"]
        models = results.collect {|m| m["Model_Name"]}
        models.each_with_index do |v, i|
            puts "#{i +1 }. #{v}"
        end 
        puts "If you want to save one of these vehicles, enter its number. Otherwise, enter 'm' to return to main menu."
        answer = gets.strip
        system("clear")
        if answer.to_i > 0 && answer.to_i < models.length
            #to integer 
            save_vehicle(models[answer.to_i - 1])
            puts "#{models[answer.to_i - 1]} has been saved to your list!"
            sleep(2)
            system("clear")
            call
        elsif answer.downcase == "m"
            system("clear")
            call
        else 
            invalid_entry
        end
    end 

    def save_vehicle(vehicle)
        @@vehicle_list << vehicle
    end

    def view_vehicle_list
        if @@vehicle_list.length > 0
            system("clear")
            @@vehicle_list.each_with_index {|val, ind| puts "#{ind + 1}. #{val}"}
            sleep(2) 
            system("clear")
            call 
        else
            system("clear")
            puts "Your current vehicle list is empty."
            sleep(2)
            system("clear")
            call
        end
    end
     

    def goodbye 
        system("clear")
        puts "Goodbye, we hope to see you soon!"
        sleep(3)
        system("clear")
        exit 
    end 

    def invalid_entry
        puts "invalid entry, try again"
        sleep(2)
        #pauses 
        call
    end 
end 
