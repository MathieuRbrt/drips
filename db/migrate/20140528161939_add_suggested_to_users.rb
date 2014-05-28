class AddSuggestedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suggested, :integer, :default => 0
  end
end
