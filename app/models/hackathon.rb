class Hackathon < ApplicationRecord
  serialize :award_wei_list, JSON
  enum status: [:preparation, :crow_funding, :apply_participation, :gaming, :voting, :finished, :failed]

  has_many :teams
  belongs_to :user

  def refresh_real_status
    current_status
    # TODO check failed status
    # check corw_funding apply voting status and set failed
  end

  # detection realtime status and update status
  def current_status
    return status if [:finished, :failed].include? status
    if address&.start_with?("0x")
      state = HacksContract::Hackathon.new(address).state
      s = case state
          when 0
            :preparation
          when 1
            :crow_funding
          when 2
            :apply_participation
          when 3
            :gaming
          when 4
            :voting
          when 5
            :finished
          else
            :failed
          end
    else
      current = Time.now
      s = if current < crow_funding_start_at
            :preparation
          elsif current < apply_start_at
            :crow_funding
          elsif current < game_start_at
            :apply_participation
          elsif current < vote_start_at
            :gaming
          elsif current < finished_at
            :voting
          else
            :finished
          end
    end

    if s != status
      update_column(:status, s)
    end
    s
  end
end
