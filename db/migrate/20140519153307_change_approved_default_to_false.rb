class ChangeApprovedDefaultToFalse < ActiveRecord::Migration
  def up
    change_column :posts, :approved, :boolean, :default => false
  end

  def down
    change_column :posts, :approved, :boolean, :default => true
  end
end
