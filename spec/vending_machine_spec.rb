require "./lib/vending_machine"

describe VendingMachine do
  subject { described_class.new }
  describe "#add_coin" do
    valid_coins = ["nickel", "dime", "quarter"]
    
    context "when a valid coin is inputed" do
      valid_coins.each do |coin|
        it "adds the coin to the total" do
          subject.add_coin(coin)
          expect(subject.accepted_coins).to eq([coin])
        end
      end
    end

    context "when multiple coins are inputed" do

      before do
        subject.add_coin("nickel")
        subject.add_coin("dime")
        subject.add_coin("penny")
        subject.add_coin("euro")
      end

      it "appends the coin to the accepted coins" do
        expect(subject.accepted_coins).to match_array(["nickel", "dime"])
      end

      it "appends the coin to the rejected coins" do
        expect(subject.rejected_coins).to match_array(["penny","euro"])
      end
    end  

    context "when an invalid coin is inputed" do
      invalid_coins = ["penny", "half-dollar"]

      invalid_coins.each do |coin|
        it "adds the coin to the rejected coin" do
          subject.add_coin(coin)
          expect(subject.rejected_coins).to eq([coin])
        end
      end
    end
  end

  describe "#display" do
    let(:total) {50}

    before do
      allow(subject).to receive(:total_in_cents) {total}
    end
    
    context "when there is a total" do
      context "when the total ends in a 0" do
        it "displays the total in $x.xx " do
          expect(subject.display).to eq "$0.50"
        end
      end
      
      context "when the total ends in a number" do
        let(:total) {55}
        it "displays the total in $x.xx " do
          expect(subject.display).to eq "$0.55"
        end
      end

      context "when the total is more than a dolla" do
        let(:total) {123}

        it "displays the total $1.xx" do
          expect(subject.display).to eq "$1.23"
        end
    end
    end

    context "when there isn't a total" do
      let(:total) {0}
      
      it "displays a message to insert coins" do
        expect(subject.display).to eq "INSERT COINS"
      end
    end
  end
  describe "#select_item" do
    before do
      allow(subject).to receive(:total_in_cents) {total}
    end
    let (:item) {"cola"}

    context "when the total is more than the value of the item" do
      let(:total) {100}

      it "sets chosen item to the value if it's valid" do
        subject.select_item(item)
        expect(subject.chosen_item).to eq "cola"
      end

      it "doesn't set chosen item to the value if it's invalid" do
        subject.select_item("bob")
        expect(subject.chosen_item).to eq ""
      end
    end
    
    context "when there are insufficient coins for selected item" do
      let(:total) {40}

      it "deosn't set chosen item" do
        subject.select_item(item)
        expect(subject.chosen_item).to eq ""
      end

      it "returns the price of the chosen item" do
        
        expect(subject.select_item(item)).to eq "PRICE $1.00"
      end
    end
  end
end