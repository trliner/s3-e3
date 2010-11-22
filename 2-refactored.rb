class Apartment
  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :commission, :neighborhood_id

  NEIGHBORHOODS = {
    :downtown => 1,
    :uptown => 2,
    :east_side => 3,
    :hyde_park => 4
  }

  def initialize(name, opts)
    @name = name
    @rent = opts[:rent]
    @bedrooms = opts[:bedrooms]
    @allow_pets = opts[:allow_pets] != false
    @allow_felonies = opts[:allow_felonies] || false
    @commission = opts[:commission] || 100
    @neighborhood_id = opts[:neighborhood_id]
  end

  def commission_check
    rent * (commission / 100.to_f)
  end

  def neighborhood
    neighborhood = NEIGHBORHOODS.invert[neighborhood_id].to_s.
      split('_').collect{|s| s.capitalize}.join(" ")
    neighborhood.empty? ? "None Specified" : neighborhood
  end
end

oaks = Apartment.new("The Oaks",
    :rent => 500,
    :bedrooms => 1,
    :neighborhood_id => Apartment::NEIGHBORHOODS[:uptown]
  )
penthouse = Apartment.new("Penthouse",
    :rent => 800,
    :bedrooms => 1,
    :allow_pets => false,
    :commission => 75,
    :neighborhood_id => Apartment::NEIGHBORHOODS[:downtown]
  )
elm = Apartment.new("Elm Apartments",
    :rent => 375,
    :bedrooms => 1,
    :allows_felonies => true,
    :neighborhood_id => Apartment::NEIGHBORHOODS[:east_side]
  )
towers = Apartment.new("The Towers",
    :rent => 650,
    :bedrooms => 1)


puts oaks.neighborhood # => "Uptown"
puts penthouse.neighborhood # => "Downtown"
puts elm.neighborhood # => "East Side"
puts towers.neighborhood # => "None Specified"