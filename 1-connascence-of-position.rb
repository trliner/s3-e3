class Apartment
  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :commission

  def initialize(
    name, rent, bedrooms, allow_pets = true, allow_felonies = false,
    commission = 100
  )
    @name = name
    @rent = rent
    @bedrooms = bedrooms
    @allow_pets = allow_pets
    @allow_felonies = allow_felonies
    @commission = commission
  end

  def commission_check
    rent * (commission / 100.to_f)
  end
end

class Client
  attr_accessor :name, :max_rent, :bedrooms, :pets, :felony

  def initialize(name, max_rent, bedrooms, pets = false, felony = false)
    @name = name
    @max_rent = max_rent
    @bedrooms = bedrooms
    @pets = pets
    @felony = felony
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
  Apartment.new("The Oaks", 500, 1),
  Apartment.new("The Oaks", 900, 2),
  Apartment.new("Penthouse", 800, 1, false, false, 75),
  Apartment.new("Penthouse", 1400, 2, false, false, 75),
  Apartment.new("Elm Apartments", 375, 1, true, true),
  Apartment.new("Elm Apartments", 550, 2, true, true)
]

agent = Agent.new(apartments)
clients = [
  Client.new("Joe", 550, 1),
  Client.new("Hammer", 700, 2, true, true),
  Client.new("Stanley", 1600, 2)
]

clients.each do |client|
  agent.print_list_for(client)
  puts "\n"
end