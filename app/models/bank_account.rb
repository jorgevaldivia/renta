class BankAccount < ActiveRecord::Base
  belongs_to :user

  store_accessor :open_pay_data, :open_pay_id
end
