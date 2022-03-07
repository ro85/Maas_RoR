class Weekday < ApplicationRecord
  has_many :weekday_setups
  has_many :monitoring_days
end
