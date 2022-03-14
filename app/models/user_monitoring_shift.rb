class UserMonitoringShift < ApplicationRecord
  belongs_to :user
  belongs_to :monitoring_shift
end
