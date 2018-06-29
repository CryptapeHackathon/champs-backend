class Hackathon < ApplicationRecord
  serialize :award_wei_list, Array
  enum status: [:preparation, :crow_funding, :apply_participation, :gaming, :voting, :finished]

  # detection realtime status and update status
  def current_status
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
