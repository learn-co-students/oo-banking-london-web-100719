##
# This class represents transfers between two account
class Transfer
  attr_accessor :amount, :status, :sender, :receiver, :bank_account
  @@all = []
  def initialize(sender, receiver, amount, status = 'pending')
    @amount = amount
    @sender = sender
    @receiver = receiver
    @status = status
    @@all << self
  end

  def self.all
    @@all
  end

  def valid?
    sender.valid? && receiver.valid? ? true : false
  end

  def execute_transaction
    if complete_transfer?
      'Transaction has already been dealt with.'
    elsif invalid_account?
      'Transaction rejected. Please check your account balance.'
    else
      confirm_transfer
      'Transaction successful.'
    end
  end

  def complete_transfer?
    status == 'complete'
  end

  def invalid_account?
    if sender.balance < amount || sender.status == 'closed' || receiver.status == 'closed'
      self.status = 'rejected'
      true
    end
  end

  def confirm_transfer
    sender.balance -= amount
    receiver.balance += amount
    self.status = 'complete'
  end

  def reverse_transfer
    if sender.valid? && receiver.valid? && status == 'complete'
      sender.balance += amount
      receiver.balance -= amount
      self.status = 'reversed'
      'Successful Reversal'
    end
  end
end
