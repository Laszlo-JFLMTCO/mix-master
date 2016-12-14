class AddLinklistColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :linklist_id, :integer
  end
end
