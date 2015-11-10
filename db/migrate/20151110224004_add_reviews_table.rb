class AddReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true
      t.references :song, index: true
      t.string :content
      t.timestamps null: false
    end
  end
end
