class CreateUsersSongsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :songs
  end
end
