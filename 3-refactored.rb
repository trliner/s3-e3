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

class Client
  attr_accessor :name, :max_rent, :bedrooms, :pets, :felony

  def initialize(name, opts)
    @name = name
    @max_rent = opts[:max_rent]
    @bedrooms = opts[:bedrooms]
    @pets = opts[:pets] || false
    @felony = opts[:felony] || false
  end
end

class Agent
  attr_accessor :apartment_list

  def initialize(apartment_list)
    @apartment_list = apartment_list
  end

  def filter_list_for(client)
    apartment_list.
      reject {|apt| client.felony && !apt.allow_felonies }.
      reject {|apt| client.pets && !apt.allow_pets }.
      reject {|apt| apt.rent > client.max_rent + 50 }.
      reject {|apt| apt.bedrooms < client.bedrooms }
  end

  def list_by_highest_commission(client)
    filter_list_for(client).
      sort{|apt1,apt2| apt2.commission_check <=> apt1.commission_check }
  end

  def list_by_lowest_rent(client)
    filter_list_for(client).sort{|apt1,apt2| apt1.rent <=> apt2.rent }
  end

  def print_list_for(client)
    client_list = list_by_highest_commission(client)
    puts client.name + ":"
    client_list.each {|a| puts "#{a.name} - #{a.bedrooms}br"}
  end

  def highest_commission_for(client)
    list_by_highest_commission(client).first.commission_check
  end

  def neighborhood_driving_order(client)
    list_by_highest_commission(client).collect{|apt| apt.neighborhood}.uniq
  end

end

# now if an agent decided to print the apartment_list and the
# neighborhood_driving_order ordered by descending rent, only the name of the
# sorting method would need to be changed

apartments = [
  Apartment.new("The Oaks",
      :rent => 500,
      :bedrooms => 1,
      :neighborhood_id => Apartment::NEIGHBORHOODS[:uptown]
    ),
  Apartment.new("Penthouse",
      :rent => 800,
      :bedrooms => 1,
      :allow_pets => false,
      :commission => 75,
      :neighborhood_id => Apartment::NEIGHBORHOODS[:downtown]
    ),
  Apartment.new("Elm Apartments",
      :rent => 375,
      :bedrooms => 1,
      :allows_felonies => true,
      :neighborhood_id => Apartment::NEIGHBORHOODS[:east_side]
    ),
  Apartment.new("The Towers",
      :rent => 650,
      :bedrooms => 1)
]

agent = Agent.new(apartments)

client = Client.new("Joe", :max_rent => 550, :bedrooms => 1)

agent.print_list_for(client)
puts agent.highest_commission_for(client)
puts agent.neighborhood_driving_order(client)