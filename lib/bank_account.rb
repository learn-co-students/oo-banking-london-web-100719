##
# This class represents a bank account
class BankAccount
  attr_reader :name
  attr_accessor :balance, :status
  @@all = []
  def initialize(name, balance = 1000, status = 'open')
    @name = name
    @balance = balance
    @status = status
    @@all << self
  end

  def self.all
    @@all
  end

  def deposit(amount)
    @balance += amount
  end

  def display_balance
    "Your balance is $#{@balance}."
  end

  def valid?
    @status == 'open' && @balance.positive? ? true : false
  end

  def close_account
    @balance = 0
    @status = 'closed'
  end

end
