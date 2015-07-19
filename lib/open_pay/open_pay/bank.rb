class OpenPay::Bank < OpenPay::Base
  private
  
  def resource_name
    :bankaccounts
  end
end