class Song < ActiveRecord::Base
  has_and_belongs_to_many :user
  validates :title, :username, presence: true
end
