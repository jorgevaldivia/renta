class Property < ActiveRecord::Base
  belongs_to :user

  validates :name, :address_line_1, :city, :state, :postal_code, presence: true
end
