class User <ActiveRecord::Base
  # has_many :songs, through: song_user
  has_many :reviews
end
