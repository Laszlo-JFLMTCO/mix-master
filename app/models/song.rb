class Song < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :artist
  has_many :linklists
  has_many :playlists, through: :linklists
end