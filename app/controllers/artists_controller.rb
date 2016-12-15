class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    @header = Hash.new(false)
    @header[:title] = "Artist List"
    @header[:show_add] = true
  end

  def create
    @artist = Artist.create(artist_params)
    if @artist.save
      redirect_to artist_path(@artist.name)
    else
      @errors = @artist.errors.full_messages
      @submit_button = "Save Artist"
      @form_url = artists_path
      @header = Hash.new(false)
      @header[:title] = "Enter new Artist"
      render :new
    end
  end

  def new
    @artist = Artist.new
    @submit_button = "Save Artist"
    @form_url = artists_path
    @header = Hash.new(false)
    @header[:title] = "Enter new Artist"
  end

  def edit
    @artist = Artist.find_by(name: params[:name])
    @submit_button = "Update Artist Info"
    @form_url = artist_path(@artist.name)
    @header = Hash.new(false)
    @header[:title] = "Edit Artist Details"
  end

  def show
    @artist = Artist.find_by(name: params[:name])
    @header = Hash.new(true)
    @header[:title] = "Artist Details"
    @header[:show_add] = false
  end

  def update
    @artist = Artist.find_by(name: params[:name])
    if @artist.update(artist_params)
      redirect_to artist_path(@artist.name)
    else
      @errors = @artist.errors.full_messages
      @submit_button = "Update Artist Info"
      @form_url = artist_path(Artist.find_by(name: params[:name]).name)
      @header = Hash.new(false)
      @header[:title] = "Edit Artist Details"
      render :edit
    end
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