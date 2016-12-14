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

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      params[:songlist].keys.each do |song_id|
        @playlist.songs << Song.find(song_id)
      end
      redirect_to playlists_path
    else
      @errors = @playlist.errors.full_messages
      @submit_button = "Save Playlist"
      @form_url = playlists_path
      render :new
    end
  end

  def new
    @submit_button = "Save Playlist"
    @form_url = playlists_path
    @header = Hash.new(false)
    @header[:title] = "Creating Playlist"
    @songs = Song.all
    @playlist = Playlist.new
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end

end