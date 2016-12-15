class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all
    @header = Hash.new(false)
    @header[:title] = "Collection of Playlists"
    @header[:show_add] = true
  end

  def edit
    @playlist = Playlist.find(params[:id])
    @submit_button = "Update Playlist"
    @form_url = playlist_path(@playlist)
    @header = header(:edit)
    @songs = Song.all
    @playlist_song_list = song_list_checkboxes(@playlist.songs.ids)
  end

  def show
    @playlist = Playlist.find(params[:id])
    @header = header(:show)
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
      old_song_list = @playlist.songs.ids
      new_song_list = []
      new_song_list = params[:songlist].keys unless params[:songlist].nil?
      new_song_list.map! {|id| id.to_i}
      add_songs = new_song_list - old_song_list
      remove_songs = old_song_list - new_song_list
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
    @header = header(:new)
    @songs = Song.all
    @playlist = Playlist.new
    @playlist_song_list = song_list_checkboxes([])
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end

  def song_list_checkboxes(playlist_song_ids)
    playlist_song_list = hash_init("")
    song_ids = Song.all.pluck(:id)
    song_ids.each do |song_id|
      playlist_song_list[song_id] = "checked" if playlist_song_ids.include?(song_id)
    end
    return playlist_song_list
  end

  def hash_init(default)
    Hash.new(default)
  end

  def header_show
    header = hash_init(false)
    header[:title] = "Playlist Details"
    header[:show_index] = true
    header[:show_edit] = true
    return header
  end

  def header_edit
    header = hash_init(false)
    header[:title] = "Edit Playlist"
    return header
  end

  def header_new
    header = hash_init(false)
    header[:title] = "Creating Playlist"
    return header
  end

  def header(route)
    return header_show if route == :show
    return header_edit if route == :edit
    return header_new if route == :new
  end


end