json.extract! hackathon, :id, :name, :address, :host_introduction, :topic, :host_fund_eth, :target_fund_eth, :teams_count, :participation_fee_eth, :award_eth_list, :vote_reward_percent, :crow_funding_start_at, :apply_start_at, :game_start_at, :vote_start_at, :finished_at, :current_status, :created_at, :updated_at
h = HacksContract::Hackathon.new(hackathon.address)
json.contract do
  %w{total_fund sign_up_goal_reached crowd_found_goal_reached closing_vote closing_crowd_fund champ crowd_fund_period champ_bonus closing_sign_up remain_crowd_fund crowd_fund_target second_bonus total_crowd_fund closing_match sign_up_period sign_up_fee third_bonus register_lower_limit third vote_period init_fund match_period state register_upper_limit is_failed}.each do |attr|
    json.set! attr, h.send(attr)
  end
end if hackathon.address.start_with?("0x")
json.url hackathon_url(hackathon, format: :json)
