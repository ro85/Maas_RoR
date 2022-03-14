class Contract < ApplicationRecord
  has_many :weekday_setups
  has_many :monitoring_shifts
  accepts_nested_attributes_for :weekday_setups
  validates :client_name, presence: true


  def total_hour_monday
    (self.monday_end_hour.to_time.to_i - self.monday_start_hour.to_time.to_i).abs/60/60
  end

  def total_hour_tuesday
    (self.tuesday_end_hour.to_time.to_i - self.tuesday_start_hour.to_time.to_i).abs/60/60
  end

  def total_hour_wednesday
    (self.wednesday_end_hour.to_time.to_i - self.wednesday_start_hour.to_time.to_i).abs/60/60
  end

  def total_hour_thursday
    (self.thursday_end_hour.to_time.to_i - self.thursday_start_hour.to_time.to_i).abs/60/60
  end  

  def total_hour_friday
    (self.friday_end_hour.to_time.to_i - self.friday_start_hour.to_time.to_i).abs/60/60
  end

  def total_hour_saturday
    (self.saturday_end_hour.to_time.to_i - self.saturday_start_hour.to_time.to_i).abs/60/60
  end

  def total_hour_sunday
    (self.saturday_end_hour.to_time.to_i - self.saturday_start_hour.to_time.to_i).abs/60/60
  end



  def total_hours_per_week
    total_hour_monday + total_hour_tuesday + total_hour_wednesday + total_hour_thursday + total_hour_friday + total_hour_saturday + total_hour_sunday
    
  end
end
