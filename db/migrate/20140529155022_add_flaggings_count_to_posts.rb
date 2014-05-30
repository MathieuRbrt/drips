class AddFlaggingsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :flaggings_count, :integer
  end
end
