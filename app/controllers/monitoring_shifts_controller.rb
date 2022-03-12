class MonitoringShiftsController < ApplicationController
  
  def index
    @monitoring_shifts = policy_scope(MonitoringShift).includes(:user)
    @weeks = ["semana"]  
    @dates = []  
    @dates_weekend = []
    @monitoring_shifts.each do |shift|
      @weeks << shift.week_number      
    end 
    
    if params[:query].present?     
      sql_query = "monitoring_shifts.week_number ILIKE :query"
      @monitoring_shifts = policy_scope(MonitoringShift).includes(:user).where(week_number: params[:query].to_i)    
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
    
  end

  def edit
    @monitoring_shift = MonitoringShift.find(params[:id])
    authorize @monitoring_shift
  end

  def update
    @monitoring_shift = MonitoringShift.find(params[:id])
    authorize @monitoring_shift
  end

  def tildar_todas
    
    params[:monitoring_shifts_ids].each do |shift_id|
      @monitoring_shift = MonitoringShift.find(shift_id.to_i)   
      @monitoring_shift.update(available: true)
    end
    authorize @monitoring_shift
    redirect_to monitoring_shifts_path 
    
    

  end
end
