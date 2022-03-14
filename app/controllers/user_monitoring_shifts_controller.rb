class UserMonitoringShiftsController < ApplicationController

  def mark_as_available
    if  params[:user_monitoring_shifts_ids] != nil
      @true_user_shifts = []
      params[:user_monitoring_shifts_ids].each do |shift_id|
        @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
        @true_user_shifts << @user_monitoring_shift
        @shift = MonitoringShift.find(@user_monitoring_shift.monitoring_shift_id)
        @week_user_shifts = UserMonitoringShift.where(user_id: current_user.id).joins(:monitoring_shift).where(:monitoring_shifts => {:week_number => @shift.week_number})      
        @week_user_shifts.each do |user_shift|
          if  @true_user_shifts.include?(user_shift)             
            user_shift.update(available: true)
          else
            user_shift.update(available: false)
          end
        end 
        
      end   
      authorize @user_monitoring_shift   
      redirect_to "/monitoring_shifts?query=#{@user_monitoring_shift.monitoring_shift.week_number}"
    else
      render "/monitoring_shifts?query=#{@user_monitoring_shift.monitoring_shift.week_number}"
    end
  end

end
