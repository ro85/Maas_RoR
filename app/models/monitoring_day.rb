class MonitoringDay < ApplicationRecord
  belongs_to :contract
  belongs_to :weekday_setup
end
