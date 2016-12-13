class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.create(artist_params)
    redirect_to artist_path(@artist.name)
  end

  def show
    @artist = Artist.find_by(name: params[:name])
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :image_path)
  end
end