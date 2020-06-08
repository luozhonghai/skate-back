class AddScoreSingleMapToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :score_single_0, :integer, :default => 0
    add_column :users, :score_single_1, :integer, :default => 0
    add_column :users, :score_single_2, :integer, :default => 0
  end
end
