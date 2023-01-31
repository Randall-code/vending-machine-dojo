class VendingMachine
  attr_reader :accepted_coins, :rejected_coins
  

  VALID_COINS = {"nickel" => 5, "dime" => 10, "quarter" => 25}
  PRODUCTS = {"cola" => 100, "chips" => 50, "candy" => 65}

  def initialize
    @accepted_coins = []
    @rejected_coins = []
    @selected_product = nil
  end

  def add_coin coin
    VALID_COINS.keys.include?(coin) ? @accepted_coins << coin : @rejected_coins << coin
  end

  def press_button product
    @selected_product = product

    PRODUCTS[product] <= total ? @selected_product : nil
  end

  def total 
    accepted_coins.map do |coin|
      VALID_COINS[coin]
    end.sum
  end

  def display
    return "PRICE #{format_currency(PRODUCTS[@selected_product])}" if @selected_product
    return "INSERT COINS" if total.zero?
    
    format_currency(total)
  end

  private

  def format_currency cents
    "$%.2f" % (cents.to_f/100)
  end
end