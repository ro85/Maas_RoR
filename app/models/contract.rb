class Contract < ApplicationRecord
  has_many :weekday_setups
  accepts_nested_attributes_for :weekday_setups
  validates :client_name, presence: true
end
