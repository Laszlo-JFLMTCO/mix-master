class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all
    @header = Hash.new(false)
    @header[:title] = "Collection of Playlists"
    @header[:show_add] = true
  end

  def show
    @playlist = Playlist.find(params[:id])
    @header = Hash.new(false)
    @header[:title] = "Playlist Details"
    @header[:show_index] = true    
  end

end