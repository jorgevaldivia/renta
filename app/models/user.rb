class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  store_accessor :open_pay_data, :open_pay_id

  has_many :bank_accounts

  before_save :create_or_update_in_open_pay
  before_destroy :destroy_from_open_pay

  def full_name
    [first_name, last_name].join(" ")
  end

  private

  def create_or_update_in_open_pay
    openpay = OpenpayApi.new(ENV["OPEN_PAY_MERCHANT_ID"], ENV["OPEN_PAY_PRIVATE_KEY"])
    customers = openpay.create(:customers)

    data = {name: full_name, email: email, requires_account: false}
    data[:id] = id unless new_record?
    self.open_pay_data = customers.create(data)
    self.open_pay_id = self.open_pay_data["id"]
  end

  def destroy_from_open_pay
    openpay = OpenpayApi.new(ENV["OPEN_PAY_MERCHANT_ID"], ENV["OPEN_PAY_PRIVATE_KEY"])
    customers = openpay.create(:customers)
    
    customers.delete(open_pay_id)
  end
end
