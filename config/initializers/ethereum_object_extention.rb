class Numeric
  def to_wei
    self * (10 ** 18)
  end

  def to_eth
    self.to_f / (10 ** 18)
  end
end
