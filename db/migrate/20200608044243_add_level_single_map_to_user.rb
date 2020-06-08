class AddLevelSingleMapToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :level_0, :integer, :default => 1
    add_column :users, :level_1, :integer, :default => 1
    add_column :users, :level_2, :integer, :default => 1
  end
end
