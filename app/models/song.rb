class Song < ActiveRecord::Base
  has_and_belongs_to_many :user
  has_many :reviews
  validates :title, :username, presence: true
end
