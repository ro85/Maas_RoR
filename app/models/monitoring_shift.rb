class MonitoringShift < ApplicationRecord
  belongs_to :user, optional: true
  has_many :user_monitoring_shifts
  belongs_to :contract
end
