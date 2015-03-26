class OpenPay::Customer < OpenPay::Base
  private
  
  def resource_name
    :customers
  end
end