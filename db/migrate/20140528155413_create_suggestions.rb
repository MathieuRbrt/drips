class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :post_id

      t.timestamps
    end
  end
end
