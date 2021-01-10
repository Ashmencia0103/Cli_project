require 'open-uri'
require 'net/http'
require 'json'

class Api

    attr_accessor :make, :year, :url 

    def initialize(make, year)
        @url = "https://vpic.nhtsa.dot.gov/api/vehicles/getmodelsformakeyear/make/#{make}/modelyear/#{year}/vehicleType/car?format=json"
    end
  

    def get_response_body
        #binding.pry
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def parse_json
        JSON.parse(self.get_response_body)
    end
end