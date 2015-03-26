class OpenPay::BankAccount < OpenPay::Base
  private
  
  def resource_name
    :bankaccounts
  end
end