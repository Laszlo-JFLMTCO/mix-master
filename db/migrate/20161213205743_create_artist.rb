class CreateArtist < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :artist_name
      t.string :artist_image_path
      
      t.timestamps null:false
    end
  end
end
