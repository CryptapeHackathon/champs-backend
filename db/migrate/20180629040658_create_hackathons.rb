class CreateHackathons < ActiveRecord::Migration[5.2]
  def change
    create_table :hackathons do |t|
      t.string :name
      t.string :host_introduction
      t.string :topic
      t.string :address
      t.integer :host_fund_wei
      t.integer :target_fund_wei
      t.integer :teams_count
      t.integer :participation_fee_wei
      t.blob :award_wei_list
      t.integer :vote_reward_percent
      t.datetime :crow_funding_start_at
      t.datetime :apply_start_at
      t.datetime :game_start_at
      t.datetime :vote_start_at
      t.datetime :finished_at
      t.integer :status

      t.timestamps
    end
  end
end
