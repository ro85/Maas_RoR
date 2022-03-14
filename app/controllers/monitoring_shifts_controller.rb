class MonitoringShiftsController < ApplicationController
  
  def index
    @monitoring_shifts = policy_scope(MonitoringShift)
    
    @weeks = ["semana"]  
    @dates = []  
    @dates_weekend = []
    MonitoringShift.all.each do |shift|
      @weeks << shift.week_number      
    end 
    
    if params[:query].present?     
      sql_query = "monitoring_shifts.week_number ILIKE :query"
      @monitoring_shifts = policy_scope(MonitoringShift).where(week_number: params[:query].to_i)    
      @monitoring_shifts.each do |shift| 
        if shift.date.saturday? || shift.date.sunday?  
          @dates_weekend << shift.date       
        else
          @dates << shift.date
        end
      end 
      
    else        
      @monitoring_shifts = @monitoring_shifts.sort{|a, b| b <=> a}              
    end   
    @monitoring_shift = MonitoringShift.new
  end

  def edit
    @monitoring_shift = MonitoringShift.find(params[:id])
    authorize @monitoring_shift
  end

  def update    
    @monitoring_shift = MonitoringShift.find(params[:id])     
    if params[:monitoring_shift][:available] == "1"
      @monitoring_shift.update(available: true)
    else
      @monitoring_shift.update(available: false)
    end
    redirect_to "/monitoring_shifts?query=#{@monitoring_shift.week_number}"
        
    authorize @monitoring_shift
  end

  def tildar_todas   
    
    params[:user_monitoring_shifts_ids].each do |shift_id|
      @user_monitoring_shift = UserMonitoringShift.find(shift_id.to_i)
      @week = @user_monitoring_shift.monitoring_shift
      @monitoring_shifts = MonitoringShift.where(week_number: @week)
      if @monitoring_shifts.include?(@user_monitoring_shift.monitoring_shift_id)
      raise
      end
      @shifts_of_week = UserMonitoringShift.where()  
      @user_monitoring_shift.update(available: true)          
    end
    authorize @user_monitoring_shift
    redirect_to "/monitoring_shifts?query=#{@user_monitoring_shift.monitoring_shift.week_number}"
    
    

  end
end
