class AddUserIdToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      add_reference :songs, :user, index: true
    end
  end
end
