class Apartment
  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :commission, :neighborhood_id

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
    if neighborhood_id == 1
      "Downtown"
    elsif neighborhood_id == 2
      "Uptown"
    elsif neighborhood_id == 3
      "East Side"
    elsif neighborhood_id == 4
      "Hyde Park"
    else
      "None Specified"
    end
  end
end

oaks = Apartment.new("The Oaks",
    :rent => 500,
    :bedrooms => 1,
    :neighborhood_id => 2
  )
penthouse = Apartment.new("Penthouse",
    :rent => 800,
    :bedrooms => 1,
    :allow_pets => false,
    :commission => 75,
    :neighborhood_id => 1
  )
elm = Apartment.new("Elm Apartments",
    :rent => 375,
    :bedrooms => 1,
    :allows_felonies => true,
    :neighborhood_id => 3
  )
towers = Apartment.new("The Towers",
    :rent => 650,
    :bedrooms => 1,
    :neighborhood_id => 4)


puts oaks.neighborhood # => "Uptown"
puts penthouse.neighborhood # => "Downtown"
puts elm.neighborhood # => "East Side"
puts towers.neighborhood # => "Hyde Park"