class UserMonitoringShiftsController < ApplicationController

  def mark_as_available   
    @false_user_shifts = [] 
    params[:false][:user_monitoring_shifts_ids].each do |shift_id|
      @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
      @user_monitoring_shift.update(available: false)      
    end
    @true_user_shifts = []
    if params[:user_monitoring_shifts_ids] != nil      
      params[:user_monitoring_shifts_ids].each do |shift_id|
        @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
        @user_monitoring_shift.update(available: true)
        @true_user_shifts << @user_monitoring_shift             
      end       
    end
    set_shift(@true_user_shifts)
    authorize @user_monitoring_shift  
    redirect_to "/monitoring_shifts/calendar_confirmed?query_contract=#{@user_monitoring_shift.monitoring_shift.contract.client_name}&query=#{@user_monitoring_shift.monitoring_shift.week_number}&button="    
    
  end

  private

  def set_shift(true_user_shifts)
    # TURNOS DE LA SEMANA
    if @true_user_shifts.empty?
      @monitoring_week_shifts = MonitoringShift.where(week_number: UserMonitoringShift.find(params[:false][:user_monitoring_shifts_ids].first).monitoring_shift.week_number)
      @monitoring_week_shifts.each do |monitoring_week_shift|
        monitoring_week_shift.update(user_id: nil)
      end
    else
      @monitoring_week_shifts = MonitoringShift.where(week_number: @true_user_shifts.first.monitoring_shift.week_number) 
    end
    # Turnos por dev que pusieron disponible de la semana del cliente
    @week_user_shifts = UserMonitoringShift.where(available: true).joins(:monitoring_shift).where(:monitoring_shifts => {:week_number => @monitoring_week_shifts.first.week_number, contract_id:  @monitoring_week_shifts.first.contract_id})  
    # Agrupados por turno y la cantidad de disponibles por turno
    @monitoring_shifts_gruoped = @week_user_shifts.group(:monitoring_shift_id).count
    # Extraigo los turnos que solo tienen un dev
    @single_dev_monitoring_shifts = @monitoring_shifts_gruoped.select { |key, value| value == 1 }.keys
    # Asigno primero los individuales
    @single_monitoring_shifts = []
    @single_dev_monitoring_shifts.each do |single_dev_monitoring_shift|
      dev_id = UserMonitoringShift.where(monitoring_shift_id: single_dev_monitoring_shift, available: true  ).first.user_id
      MonitoringShift.find(single_dev_monitoring_shift).update(user_id: dev_id)
      @single_monitoring_shifts << MonitoringShift.find(single_dev_monitoring_shift)
    end
    # Volver a contar para ver orden de mas turnos por por dev      

    @not_single_dev_monitoring_week_shifts = @monitoring_week_shifts - @single_monitoring_shifts
    
    @not_single_dev_monitoring_week_shifts.each do |monitoring_shift| 
      @devs_id = @monitoring_week_shifts.group(:user_id).count.sort_by(&:last).to_h.keys
      @user_true_monitoring_shifts = []
      @user_monitoring_shifts_ids = []  
      if UserMonitoringShift.where(monitoring_shift_id: monitoring_shift.id).where(available: true).empty?
        monitoring_shift.update(user_id: nil) 
      else
        UserMonitoringShift.where(monitoring_shift_id: monitoring_shift.id).where(available: true).each do |user_monitoring_shift|                            
          @devs_id.each_with_index do |dev, position|                    
            if dev != nil && user_monitoring_shift.monitoring_shift_id == monitoring_shift.id
              if @devs_id.exclude?(user_monitoring_shift.monitoring_shift.user_id)
                MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).update(user_id: user_monitoring_shift.user_id)
              else
                if @devs_id.index(MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).user_id) != nil                  
                  if position < @devs_id.index(MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).user_id)                            
                    MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).update(user_id: dev)
                  elsif position > @devs_id.index(MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).user_id)
                    MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).update(user_id: MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).user_id)
                  else
                    MonitoringShift.find(user_monitoring_shift.monitoring_shift_id).update(user_id: dev)
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
