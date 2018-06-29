class User < ApplicationRecord

  before_create :generate_token
  after_create :generate_bind_token

  def generate_token
    self.token = SecureRandom.hex
  end

  def generate_bind_token
    self.bind_token = Digest::SHA256.hexdigest("#{id}-#{token}")
  end
end
