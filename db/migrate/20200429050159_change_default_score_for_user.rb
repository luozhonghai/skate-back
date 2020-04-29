class ChangeDefaultScoreForUser < ActiveRecord::Migration[6.0]

  def up
    change_column_default :users, :score_0_online, "-1.0"
    change_column_default :users, :score_1_online, "-1.0"
    change_column_default :users, :score_2_online, "-1.0"
  end

  def down
    change_column_default :users, :score_0_online, "0.0"
    change_column_default :users, :score_1_online, "0.0"
    change_column_default :users, :score_2_online, "0.0"
  end

end
