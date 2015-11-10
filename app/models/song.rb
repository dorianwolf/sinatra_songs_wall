class Song < ActiveRecord::Base
  belongs_to :user
  validates :title, :author, :user, presence: true
end
