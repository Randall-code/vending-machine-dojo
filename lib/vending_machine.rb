class VendingMachine
  attr_reader :accepted_coins, :rejected_coins
  

  VALID_COINS = {"nickel" => 5, "dime" => 10, "quarter" => 25}

  def initialize
    @accepted_coins = []
    @rejected_coins = []
  end

  def add_coin coin
    VALID_COINS.keys.include?(coin) ? @accepted_coins << coin : @rejected_coins << coin
  end

  def total 
    accepted_coins.map do |coin|
      VALID_COINS[coin]
    end.sum
  end

  def display
    return "INSERT COINS" if total.zero? 
      
    "$#{total.to_f / 100}0"
  end
end