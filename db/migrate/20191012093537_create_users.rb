class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :device_id, :unique => true
      t.string :nickname
      t.integer :level
      t.integer :score_single
      t.decimal :score_0_online, :precision => 9, :scale => 3, :default => '0.0'
      t.decimal :score_1_online, :precision => 9, :scale => 3, :default => '0.0'
      t.decimal :score_2_online, :precision => 9, :scale => 3, :default => '0.0'

      t.integer :try_challenge
      t.integer :win_challenge

      t.timestamps
    end
  end
end
