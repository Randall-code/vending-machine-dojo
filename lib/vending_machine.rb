class VendingMachine
  attr_reader :accepted_coins, :rejected_coins, :chosen_item
  

  VALID_COINS = {"nickel" => 5, "dime" => 10, "quarter" => 25}
  VALID_ITEMS = {"cola" => 100, "chips" => 50, "candy" => 65}

  def initialize
    @accepted_coins = []
    @rejected_coins = []
    @chosen_item = ""
  end

  def add_coin coin
    VALID_COINS.keys.include?(coin) ? @accepted_coins << coin : @rejected_coins << coin
  end

  def display
    return "INSERT COINS" if total_in_cents.zero? 
      
    total_in_dollars(total_in_cents)
  end

  def select_item(item) 
    return if VALID_ITEMS[item].nil?
    return "PRICE #{total_in_dollars(VALID_ITEMS[item])}"  if VALID_ITEMS[item] > total_in_cents

    @chosen_item = item
  end

  private 

  def total_in_cents
    accepted_coins.map do |coin|
      VALID_COINS[coin]
    end.sum
  end

  def total_in_dollars(total)
    "$%.2f" % (total.to_f / 100)
  end

end