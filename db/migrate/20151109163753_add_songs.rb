class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.string :url, default: ''
      t.timestamps null: false
    end
  end
end
