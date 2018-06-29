class CreateHackathons < ActiveRecord::Migration[5.2]
  def change
    create_table :hackathons do |t|
      t.string :name
      t.string :host_introduction
      t.string :topic
      t.string :address
      t.decimal :host_fund_eth, precision: 27, scale: 18
      t.decimal :target_fund_eth, precision: 27, scale: 18
      t.integer :teams_count
      t.decimal :participation_fee_eth, precision: 27, scale: 18
      t.text :award_eth_list
      t.integer :vote_reward_percent
      t.datetime :crow_funding_start_at
      t.datetime :apply_start_at
      t.datetime :game_start_at
      t.datetime :vote_start_at
      t.datetime :finished_at
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
