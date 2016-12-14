class RenameListlinkInPlaylists < ActiveRecord::Migration
  def change
    rename_column :playlists, :listlink_id, :linklist_id
  end
end
