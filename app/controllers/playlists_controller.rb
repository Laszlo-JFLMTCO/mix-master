class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all
    @header = Hash.new(false)
    @header[:title] = "Collection of Playlists"
    @header[:show_add] = true
  end

  def edit
    @playlist = Playlist.find(params[:id])
    @header = Hash.new(false)
    @header[:title] = "Edit Playlist"
    @submit_button = "Update Playlist"
    @form_url = playlist_path(@playlist)
    @songs = Song.all
    @song_ids = Song.all.pluck(:id)
    @playlist_song_ids = @playlist.songs.pluck(:id)
    @playlist_song_list = Hash.new("")
    @song_ids.each do |song_id|
      @playlist_song_list[song_id] = "checked" if @playlist_song_ids.include?(song_id)
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
    @header = Hash.new(false)
    @header[:title] = "Playlist Details"
    @header[:show_index] = true
    @header[:show_edit] = true
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      updated_song_list = []
      updated_song_list = params[:songlist].keys unless params[:songlist].nil?

      updated_song_list.each do |song_id|
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

  def update
    @playlist = Playlist.find(params[:id])
    @playlist.update(playlist_params)
    if @playlist.save
      old_song_list = @playlist.songs.pluck(:id)
      updated_song_list = []
      updated_song_list = params[:songlist].keys unless params[:songlist].nil?
      updated_song_list.map! {|id| id.to_i}
      add_songs = updated_song_list - old_song_list
      remove_songs = old_song_list - updated_song_list
      add_songs.each do |song_id|
        @playlist.songs << Song.find(song_id)
      end
      remove_songs.each do |song_id|
        @playlist.songs.delete(Song.find(song_id))
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
    @song_ids = Song.all.pluck(:id)
    @playlist = Playlist.new
    @playlist_song_ids = []
    @playlist_song_list = Hash.new("")
    @song_ids.each do |song_id|
      @playlist_song_list[song_id] = "checked" if @playlist_song_ids.include?(song_id)
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end

end