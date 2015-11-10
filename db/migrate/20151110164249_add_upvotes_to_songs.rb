class AddUpvotesToSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :author, :string
    add_column :songs, :upvotes, :integer
    add_column :users, :passowrd_digest, :string
  end
end
