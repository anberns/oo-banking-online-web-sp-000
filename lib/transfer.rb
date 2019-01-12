class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amt)
    @sender = sender 
    @receiver = receiver
    @status = "pending"
    @amount = amt
  end
  
  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end
  
  def execute_transaction
    @sender.
      
end



  let(:avi) { BankAccount.new("Avi") }
  let(:amanda) { BankAccount.new("Amanda") }
  let(:transfer) { Transfer.new(amanda, avi, 50) }
  let(:bad_transfer) { Transfer.new(amanda, avi, 4000) }

  describe 'initialize' do
   

  describe '#execute_transaction' do
    it "can execute a successful transaction between two accounts" do
      transfer.execute_transaction
      expect(amanda.balance).to eq(950)
      expect(avi.balance).to eq(1050)
      expect(transfer.status).to eq("complete")
    end

    it "each transfer can only happen once" do
      transfer.execute_transaction
      expect(amanda.balance).to eq(950)
      expect(avi.balance).to eq(1050)
      expect(transfer.status).to eq("complete")
      transfer.execute_transaction
      expect(amanda.balance).to eq(950)
      expect(avi.balance).to eq(1050)
    end

    it "rejects a transfer if the sender doesn't have a valid account" do
      expect(bad_transfer.execute_transaction).to eq("Transaction rejected. Please check your account balance.")
      expect(bad_transfer.status).to eq("rejected")
    end
  end

  describe '#reverse_transfer' do
    it "can reverse a transfer between two accounts" do
      transfer.execute_transaction
      expect(amanda.balance).to eq(950)
      expect(avi.balance).to eq(1050)
      transfer.reverse_transfer
      expect(avi.balance).to eq(1000)
      expect(amanda.balance).to eq(1000)
      expect(transfer.status).to eq("reversed")
    end

    it "it can only reverse executed transfers" do
      transfer.reverse_transfer
      expect(amanda.balance).to eq(1000)
      expect(avi.balance).to eq(1000)
    end
  end
end