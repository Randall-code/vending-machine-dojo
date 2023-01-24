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

  describe "#total" do

    context "when there are coins" do
      before do
        subject.add_coin("nickel")
        subject.add_coin("dime")
      end

      it "calculates the total" do
        expect(subject.total).to eq(15)
      end
    end

    context "when there are no coins" do
      it "returns zero" do
        expect(subject.total).to eq(0)
      end
    end
  end

  describe "#display" do
    let(:total) {50}

    before do
      allow(subject).to receive(:total) {total}
    end
    
    context "when there is a total" do
      it "displays the total in $x.xx format" do
        expect(subject.display).to eq "$0.50"
      end
    end

    context "when there isn't a total" do
      let(:total) {0}
      
      it "displays a message to insert coins" do
        expect(subject.display).to eq "INSERT COINS"
      end
    end
  end
end