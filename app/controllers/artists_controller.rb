class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    @header = Hash.new(false)
    @header[:title] = "Artist List"
    @header[:show_add] = true
  end

  def new
    @artist = Artist.new
    @submit_button = "Save Artist"
  end

  def create
    @artist = Artist.create(artist_params)
    if @artist.save
      redirect_to artist_path(@artist.name)
    else
      @errors = @artist.errors.full_messages
      render :new
    end
  end

  def edit
    @artist = Artist.find_by(name: params[:name])
    @submit_button = "Update Artist Info"
  end

  def update
    @artist = Artist.find_by(name: params[:name])
    @artist.update(params[:artist])
    if @artist.save
      redirect_to artist_path(@artist.name)
    else
      @errors = @artist.errors.full_messages
      render :edit
    end
  end

  def show
    @artist = Artist.find_by(name: params[:name])
    @header = Hash.new(true)
    @header[:title] = "Artist Details"
    @header[:show_add] = false
  end

  def destroy
    artist = Artist.find_by(name: params[:name])
    Artist.delete(artist)
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :image_path)
  end
end