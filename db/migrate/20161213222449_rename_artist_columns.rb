class RenameArtistColumns < ActiveRecord::Migration
  def change
    rename_column :artists, :artist_name, :name
    rename_column :artists, :artist_image_path, :image_path
  end
end
