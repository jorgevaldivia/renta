class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  store_accessor :open_pay_data, :open_pay_id

  has_many :bank_accounts, dependent: :destroy
  has_many :properties, dependent: :destroy

  before_save :create_or_update_in_open_pay
  before_destroy :destroy_from_open_pay

  validates :first_name, :last_name, presence: :true

  def full_name
    [first_name, last_name].join(" ")
  end

  private

  # When a user is saved or created, update his info in open pay.
  def create_or_update_in_open_pay
    if first_name_changed? || last_name_changed? || email_changed?
      response = OpenPay::Customer.
        new(open_pay_id).
        save({id: open_pay_id, name: full_name, email: email, requires_account: false})

      self.open_pay_data = response
    end
  end

  # Delete user from open pay when a user is deleted.
  def destroy_from_open_pay
    OpenPay::Customer.new.destroy(open_pay_id) if open_pay_id.present?
  end
end
