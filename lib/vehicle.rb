class Vehicle

    attr_accessor :make, :model, :year, :vehicle_class

    @@all = []

    def initialize (make, model, year, vehicle_class)
      @make = make
      @model = model
      @year = year
      @vehicle_class = vehicle_class
      save
    end

    def save
      @@all << self
    end
    
    def self.all
      @@all
    end
  end