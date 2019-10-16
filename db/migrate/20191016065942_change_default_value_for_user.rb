class ChangeDefaultValueForUser < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :try_challenge, 0
    change_column_default :users, :win_challenge, 0
    change_column_default :users, :level, 1
    change_column_default :users, :score_single, 0

  end

  def down
    change_column_default :users, :try_challenge, nil
    change_column_default :users, :win_challenge, nil
    change_column_default :users, :level, nil
    change_column_default :users, :score_single, nil

  end
end
