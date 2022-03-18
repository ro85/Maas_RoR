class Contract < ApplicationRecord
  has_many :weekday_setups
  has_many :monitoring_shifts
  accepts_nested_attributes_for :weekday_setups

  validates :client_name, presence: true  
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :start_date_after_today
  validate :start_finish_check_monday
  validate :start_finish_check_tuesday
  validate :start_finish_check_wednesday
  validate :start_finish_check_thursday
  validate :start_finish_check_friday
  validate :start_finish_check_saturday
  validate :start_finish_check_sunday

  def total_hour_monday
    if self.monday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.monday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.monday_start_hour.to_time.to_i)/60/60
    else
      (self.monday_end_hour.to_time.to_i - self.monday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hour_tuesday
    if self.tuesday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.tuesday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.tuesday_start_hour.to_time.to_i)/60/60
    else
      (self.tuesday_end_hour.to_time.to_i - self.tuesday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hour_wednesday
    if self.wednesday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.wednesday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.wednesday_start_hour.to_time.to_i)/60/60
    else
      (self.wednesday_end_hour.to_time.to_i - self.wednesday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hour_thursday
    if self.thursday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.thursday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.thursday_start_hour.to_time.to_i)/60/60
    else
      (self.thursday_end_hour.to_time.to_i - self.thursday_start_hour.to_time.to_i).abs/60/60
    end
  end  

  def total_hour_friday
    if self.friday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.friday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.friday_start_hour.to_time.to_i)/60/60
    else
      (self.friday_end_hour.to_time.to_i - self.friday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hour_saturday
    if self.saturday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.saturday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.saturday_start_hour.to_time.to_i)/60/60
    else
      (self.saturday_end_hour.to_time.to_i - self.saturday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hour_sunday
    if self.sunday_end_hour.to_time == "2000-01-01 00:00:00 +0000" || self.sunday_end_hour.to_time == "2000-01-01 23:59:00 +0000"
      ("2000-01-01 24:00:00 +0000".to_time.to_i - self.sunday_start_hour.to_time.to_i)/60/60
    else
      (self.sunday_end_hour.to_time.to_i - self.sunday_start_hour.to_time.to_i).abs/60/60
    end
  end

  def total_hours_per_week
    total_hour_monday + total_hour_tuesday + total_hour_wednesday + total_hour_thursday + total_hour_friday + total_hour_saturday + total_hour_sunday    
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
 end

  def start_date_after_today
    return if end_date.blank? || start_date.blank?

    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  def end_hour_after_start_hour
    return if end_date.blank? || start_date.blank?

    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  def start_finish_check_monday
    return if monday_start_hour > monday_end_hour
    
    errors.add(:monday_end_hour, "Please select a time later than the start time") if monday_start_hour > monday_end_hour
  end
  def start_finish_check_tuesday
    return if tuesday_start_hour > tuesday_end_hour
    
    errors.add(:tuesday_end_hour, "Please select a time later than the start time") if tuesday_start_hour > tuesday_end_hour
  end
  def start_finish_check_wednesday
    return if wednesday_start_hour > wednesday_end_hour
    
    errors.add(:wednesday_end_hour, "Please select a time later than the start time") if wednesday_start_hour > wednesday_end_hour
  end
  def start_finish_check_thursday
    return if thursday_start_hour > thursday_end_hour
    
    errors.add(:thursday_end_hour, "Please select a time later than the start time") if thursday_start_hour > thursday_end_hour
  end
  def start_finish_check_friday
    return if friday_start_hour > friday_end_hour
    
    errors.add(:friday_end_hour, "Please select a time later than the start time") if friday_start_hour > friday_end_hour
  end
  def start_finish_check_saturday
    return if saturday_start_hour > saturday_end_hour
    errors.add(:saturday_end_hour, "Please select a time later than the start time") if saturday_start_hour > saturday_end_hour
  end
  def start_finish_check_sunday
    return if sunday_start_hour > sunday_end_hour
    
    errors.add(:sunday_end_hour, "Please select a time later than the start time") if sunday_start_hour > sunday_end_hour
  end

 
end
