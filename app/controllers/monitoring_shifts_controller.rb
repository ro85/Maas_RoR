class MonitoringShiftsController < ApplicationController
  
  def index
    @monitoring_shifts = policy_scope(MonitoringShift)
    
    @weeks = ["semana"]  
    @dates = []  
    @dates_weekend = []
    MonitoringShift.all.each do |shift|
      @weeks << shift.week_number      
    end 
    
    if params[:query].present? && params[:query] != "semana"    
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

  def set
    @monitoring_shifts = MonitoringShift.all
    authorize @monitoring_shifts
    @weeks = ["semana"]  
    @dates = []  
    @dates_weekend = []
    MonitoringShift.all.each do |shift|
      @weeks << shift.week_number      
    end 
    
    if params[:query].present? && params[:query] != "semana"
      sql_query = "monitoring_shifts.week_number ILIKE :query"
      @monitoring_shifts = MonitoringShift.where(week_number: params[:query].to_i)    
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

  def calendar_confirmed
    @monitoring_shifts = policy_scope(MonitoringShift)
    authorize @monitoring_shifts
    set_values    
    if params[:query].present? && params[:query] != "semana"
      sql_query_contract = "contract.client_name ILIKE :query"
      sql_query = "monitoring_shifts.week_number ILIKE :query"
      @monitoring_shifts = policy_scope(MonitoringShift).where(week_number: params[:query].to_i).joins(:contract).where(:contracts => {:client_name => params[:query_contract]})      
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
  
  private
  def set_values
    @weeks = ["semana"]  
    @dates = []  
    @dates_weekend = []
    MonitoringShift.all.each do |shift|
      @weeks << shift.week_number      
    end 
    @contracts = []
    Contract.all.each do |contract|
      @contracts << contract.client_name      
    end 
  end
end
