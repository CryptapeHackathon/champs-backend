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
    if s != status
      update_column(:status, s)
    end
    s
  end
end
