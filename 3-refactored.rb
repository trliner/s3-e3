require 'digest'

module KeyEncoder

  def key_encoder(key)
    Digest::SHA1.hexdigest(key)
  end

end

class Apartment
  include KeyEncoder

  attr_accessor :name, :rent, :bedrooms, :allow_pets, :allow_felonies,
    :lock

  def initialize(name, opts)
    @name = name
    @rent = opts[:rent]
    @bedrooms = opts[:bedrooms]
    @allow_pets = opts[:allow_pets] != false
    @allow_felonies = opts[:allow_felonies] || false
    @lock = opts[:lock]
  end

  def open_door(encoded_key)
    if key_encoder(lock) == encoded_key
      puts "opened!"
    else
      puts "got another key?"
    end
  end

end

class Agent
  include KeyEncoder

  attr_accessor :key

  def initialize(key)
    @key = key
  end

  def encoded_key
    key_encoder(key)
  end

end


oaks = Apartment.new("The Oaks",
  :rent => 500,
  :bedrooms => 1,
  :lock => "key_fits"
)

agent1 = Agent.new("key_fits")
agent2 = Agent.new("key_doesnt_fit")

puts "Agent 1:"
oaks.open_door(agent1.encoded_key)
puts "Agent 2:"
oaks.open_door(agent2.encoded_key)