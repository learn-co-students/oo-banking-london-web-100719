require 'pry'
class Transfer

  attr_accessor :sender, :receiver, :status, :pending, :amount

  def initialize(sender, receiver, status="pending", amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end 

  def execute_transaction
    if transfer_already_executed?
      return "Transaction has already been dealt with."
    elsif accounts_are_invalid?
      return "Transaction rejected. Please check your account balance."
    else
      confirm_execute_transaction
      return "Transaction successful."
    end
  end

  def transfer_already_executed?
    self.status == "complete"  
  end

  def accounts_are_invalid?
    if self.sender.balance < self.amount || self.sender.status == "closed" || self.receiver.status == "closed"
      self.status = "rejected"
      return true
    end
  end

  def confirm_execute_transaction
    self.sender.balance -= self.amount
    self.receiver.balance += self.amount
    self.status = "complete"
  end

  def reverse_transfer
    if self.sender.valid? && self.receiver.valid? && self.status == "complete"
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = "reversed"
      return "Successful Reversal"
    end
  end
  
end