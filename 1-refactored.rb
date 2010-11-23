class Apartment
  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :commission

  def initialize(name, opts)
    @name = name
    @rent = opts[:rent]
    @bedrooms = opts[:bedrooms]
    @allow_pets = opts[:allow_pets] != false
    @allow_felonies = opts[:allow_felonies] || false
    @commission = opts[:commission] || 100
  end

  def commission_check
    rent * (commission / 100.to_f)
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

  def print_list_for(client)
    client_list = sort_list_for(client)
    puts client.name + ":"
    client_list.each {|a| puts "#{a.name} - #{a.bedrooms}br"}
  end

  def sort_list_for(client)
    apartment_list.
      reject {|apt| client.felony && !apt.allow_felonies }.
      reject {|apt| client.pets && !apt.allow_pets }.
      reject {|apt| apt.rent > client.max_rent + 50 }.
      reject {|apt| apt.bedrooms < client.bedrooms }.
      sort{|apt1,apt2| apt2.commission_check <=> apt1.commission_check }
  end

end

apartments = [
  Apartment.new("The Oaks", :rent => 500, :bedrooms => 1),
  Apartment.new("The Oaks", :rent => 900, :bedrooms => 2),

  Apartment.new("Penthouse",
    :rent => 800,
    :bedrooms => 1,
    :allow_pets => false,
    :commission => 75
  ),
  Apartment.new("Penthouse",
    :rent => 1400,
    :bedrooms => 2,
    :allow_pets => false,
    :commission => 75
  ),
  Apartment.new("Elm Apartments",
    :rent => 375,
    :bedrooms => 1,
    :allows_felonies => true
  ),
  Apartment.new("Elm Apartments",
    :rent => 550,
    :bedrooms => 2,
    :allow_felonies => true)
]

agent = Agent.new(apartments)
clients = [
  Client.new("Joe", :max_rent => 550, :bedrooms => 1),
  Client.new("Hammer",
    :max_rent => 700,
    :bedrooms => 2,
    :pets => true,
    :felony => true
  ),
  Client.new("Stanley", :max_rent => 1600, :bedrooms => 2)
]

clients.each do |client|
  agent.print_list_for(client)
  puts "\n"
end