require './data_mapper_setup'
require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  include DataMapper::Resource

  has n, :tags, through: Resource

  property :id, Serial
  property :name, String
  property :url, String

end
