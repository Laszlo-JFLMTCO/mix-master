class SongsController < ApplicationController

  def create
    @artist = Artist.find_by(name: params[:artist_name])
    @song = Song.new(song_params)
    if @artist.songs << @song.save
      redirect_to song_path(@song)
    else
      @errors = @artist.errors.full_messages
    end
  end

  def new
    @artist = Artist.find_by(name: params[:artist_name])
    @song = @artist.songs.new
    @header = Hash.new(false)
    @header[:title] = "Add new song"
    @submit_button = "Save Song"
  end

  def show
    @song = Song.find(params[:id])
    @header = Hash.new(false)
    @header[:title] = "Song Details"
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end
end