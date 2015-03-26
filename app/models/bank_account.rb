class BankAccount < ActiveRecord::Base
  belongs_to :user

  store_accessor :open_pay_data, :open_pay_id

  before_save :create_or_update_in_open_pay
  before_destroy :destroy_from_open_pay

  private

  # When a bank account is saved or created, update its info in open pay.
  def create_or_update_in_open_pay
    # Bank Accounts can't be updated in open pay for some dumb reason. So
    # delete and re-create.
    if new_record?
      response = create_in_open_pay
    else
      destroy_from_open_pay
      response = create_in_open_pay
    end

    self.open_pay_data = response
  end

  # Create only, since no updates are allowed.
  def create_in_open_pay
    OpenPay::BankAccount.
      new(user.open_pay_id).
      save({id: open_pay_id, holder_name: holder_name, clabe: clabe})
  end

  # Delete bank account from open pay when a bank account is deleted.
  def destroy_from_open_pay
    OpenPay::BankAccount.new(user.open_pay_id).destroy(open_pay_id) if open_pay_id.present?
    self.open_pay_data = {}
  end
end
