class AddUsernameToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      add_column :songs, :username, :string
    end
  end
end
