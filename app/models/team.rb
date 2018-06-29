class Team < ApplicationRecord
  belongs_to :hackathon
  belongs_to :user
end
