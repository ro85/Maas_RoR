class UserMonitoringShiftsController < ApplicationController

  def mark_as_available    
    params[:false][:user_monitoring_shifts_ids].each do |shift_id|
      @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
      @user_monitoring_shift.update(available: false)
    end
    if params[:user_monitoring_shifts_ids] != nil
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
    @monitoring_week_shifts = MonitoringShift.where(week_number: @true_user_shifts.first.monitoring_shift.week_number) 
    @monitoring_week_shifts.order(:id).each do |monitoring_shift|   
      @user_true_monitoring_shifts = []
      @user_monitoring_shifts_ids = []  
      if UserMonitoringShift.where(monitoring_shift_id: monitoring_shift.id).where(available: true).empty?
        monitoring_shift.update(user_id: nil) 
      else
        UserMonitoringShift.where(monitoring_shift_id: monitoring_shift.id).where(available: true).each do |user_monitoring_shift|
          @user_true_monitoring_shifts << user_monitoring_shift
          @user_monitoring_shifts_ids << user_monitoring_shift.user_id   
          if @user_true_monitoring_shifts.count == 1
            monitoring_shift.update(user_id: @user_true_monitoring_shifts.first.user_id)
          else
            @user_true_monitoring_shifts.each do |user_true_monitoring_shift|              
              @devs_id = @monitoring_week_shifts.group(:user_id).count.sort_by(&:last).to_h.keys    
              @devs_id.each_with_index do |dev, position|                    
                if dev != nil && user_true_monitoring_shift.id == user_true_monitoring_shift.monitoring_shift_id
                  if position < @devs_id.index(user_true_monitoring_shift.monitoring_shift_id)                            
                    user_true_monitoring_shift.monitoring_shift_id.update(user_id: dev)
                  end
                end              
              end         
            end
          end                  
        end         
      end    
    end   
  end
end
