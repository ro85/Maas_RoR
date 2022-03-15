class UserMonitoringShiftsController < ApplicationController

  def mark_as_available    
    params[:false][:user_monitoring_shifts_ids].each do |shift_id|
      @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
      @user_monitoring_shift.update(available: false)
    end
    if  params[:user_monitoring_shifts_ids] != nil
      @true_user_shifts = []
      params[:user_monitoring_shifts_ids].each do |shift_id|
        @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
        @user_monitoring_shift.update(available: true)
        @true_user_shifts << @user_monitoring_shift             
      end      
      set_shift
      authorize @user_monitoring_shift  
      redirect_to "/monitoring_shifts/calendar_confirmed?query_contract=#{@user_monitoring_shift.monitoring_shift.contract.client_name}&query=#{@user_monitoring_shift.monitoring_shift.week_number}&button="
    else
      render "/monitoring_shifts?query=#{@user_monitoring_shift.monitoring_shift.week_number}"
    end
  end

  def set_shift
    @monitoring_shifts = MonitoringShift.where(week_number: @true_user_shifts.first.monitoring_shift.week_number)
    @user_monitoring_shifts = []
    @user_monitoring_shifts_ids = []
    @monitoring_shifts.each do |shift|     
      if UserMonitoringShift.where(monitoring_shift_id: shift.id).where(available: true) != nil
        UserMonitoringShift.where(monitoring_shift_id: shift.id).where(available: true).each do |user_monitoring_shift|
          @user_monitoring_shifts << user_monitoring_shift
          @user_monitoring_shifts_ids << user_monitoring_shift.user_id
        end       
      end   
    end       
    @user_monitoring_shifts.each do |shift|  
      if @user_monitoring_shifts.count == 1
        shift.monitoring_shift.update(user_id: @user_monitoring_shifts.first.user_id)
      elsif @user_monitoring_shifts.count >= 2     
        @devs_id = @monitoring_shifts.group(:user_id).count               
        @devs_id.each do |dev|                    
          if (dev[0] != nil && @user_monitoring_shifts_ids.include?(dev[0])) && shift.monitoring_shift.user_id == dev[0] && shift.monitoring_shift.user_id != nil           
            shift.monitoring_shift.update(user_id: dev[0])
          end              
        end         
      end
    end
  end
end
