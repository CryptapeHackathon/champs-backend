class User < ApplicationRecord

  before_create :generate_token
  after_create :generate_bind_token

  def generate_token
    self.token = SecureRandom.random_bytes
  end

  def generate_bind_token
    self.bind_token = Digest::SHA256.digest("#{id}-#{token}")
  end
end
