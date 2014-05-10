class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :location
      t.text :infos

      t.timestamps
    end
  end
end
