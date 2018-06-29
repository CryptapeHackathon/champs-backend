# This will guess the User class
FactoryBot.define do
  factory :user do
    name {Faker::HarryPotter.character}
    introduction {Faker::HarryPotter.quote}
    address {Faker::Bitcoin.address}
    password_digest ""
  end

  factory :hackathon do
    user
    name {Faker::Witcher.quote}
    address {Faker::Bitcoin.address}
    host_introduction {Faker::Witcher.witcher}
    topic {Faker::Witcher.school}
    host_fund_eth {rand(2..50)}
    teams_count {rand(8..20)}
    participation_fee_eth {rand(0.1..3)}
    award_eth_list {3.times.map {rand(1..5)}}
    vote_reward_percent {10}
    crow_funding_start_at {Faker::Time.between(Date.today, 2.days.since, :all)}
    apply_start_at {Faker::Time.between(2.days.since, 5.days.since, :all)}
    game_start_at {Faker::Time.between(5.days.since, 8.days.since, :all)}
    vote_start_at {Faker::Time.between(8.days.since, 9.days.since, :all)}
    finished_at {Faker::Time.between(9.days.since, 11.days.since, :all)}
    status {rand Hackathon.statuses.count}
  end

  factory :team do
    user
    hackathon
    introduction {Faker::Witcher.quote}
    name {Faker::Witcher.witcher}
  end
end
