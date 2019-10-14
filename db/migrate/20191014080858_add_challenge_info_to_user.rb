class AddChallengeInfoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :challenge_request, :text
    add_column :users, :challenge_result, :text
  end
end
