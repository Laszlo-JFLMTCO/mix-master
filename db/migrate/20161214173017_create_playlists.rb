class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title
      t.integer :listlink_id

      t.timestamps null: false
    end
  end
end
