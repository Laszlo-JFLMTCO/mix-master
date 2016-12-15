class Playlist < ActiveRecord::Base
  has_many :linklists
  has_many :songs, through: :linklists do
    def ids
      pluck(:id)
    end
  end
end