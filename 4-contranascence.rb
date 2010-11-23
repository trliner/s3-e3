class Apartment
  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :commission, :neighborhood_id

# the values in this hash must all be distinct otherwise the neighborhood
# method wouldn't work as expected. In order to avoid such problems, a test
# could be written to validate the uniqueness of each value.
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