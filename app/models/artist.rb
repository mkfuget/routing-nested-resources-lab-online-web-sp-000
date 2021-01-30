class Artist < ActiveRecord::Base
  has_many :songs
  extend ArtistsHelper

end
