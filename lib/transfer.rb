require 'pry'

class Transfer

  attr_reader :sender, :receiver
  attr_accessor :amount, :status 

  def initialize(sender, receiver, amount)
      @sender = sender 
      @receiver = receiver 
      @amount = amount
      @status = "pending"
  end

  def valid?
    if sender.valid? == true && receiver.valid? == true
      true 
    else
      false
    end
  end

  def execute_transaction
  
    if self.valid? && @status == "pending" && sender.balance > @amount
      @sender.balance -= amount 
      @receiver.balance += amount
      @status = "complete"

    else
      @status = "rejected"
      p "Transaction rejected. Please check your account balance."
    end
# binding.pry 
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance += amount 
      @receiver.balance -= amount
      @status = "reversed"
    end
  end

end  
