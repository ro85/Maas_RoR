class ContractsController < ApplicationController

  def index
    @contracts = policy_scope(Contract)  
     
    @contracts = @contracts.order('id DESC')
    if params[:query].present?
      if params[:query].to_i == 0
        sql_query = "client_name ILIKE :query"
        @contracts = policy_scope(Contract.where(sql_query, query: "%#{params[:query]}%"))
        @contracts = @contracts.order('contracts.id DESC') 
      else
        sql_query = "contracts.id ILIKE :query".to_i
        @contracts =policy_scope(Contract.where(id: params[:query].to_i))
      end
    else
      @contracts = policy_scope(Contract)
      @contracts =  @contracts.order('id DESC')
    end       
  end

  def show
    @contract = Contract.find(params[:id])    
    authorize @contract
  end

  def new
    @contract = Contract.new    
    authorize @contract    
  end

  def create
    @contract = Contract.new(params_contract) 
    if @contract.save!
      authorize @contract      
      @d = 0     
      date = @contract.start_date.to_date
      loop do                           
        case (date + @d).strftime('%A')                  
        when "Monday"          
          number_of_shift_per_day = @contract.total_hour_monday            
          @i = 0
          start_hour = @contract.monday_start_hour + (@i * 3600 )                   
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)          
        when "Tuesday"
          number_of_shift_per_day = @contract.total_hour_tuesday 
          @i = 0
          start_hour = @contract.tuesday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)    
        when "Wednesday"
          number_of_shift_per_day = @contract.total_hour_wednesday
          @i = 0
          start_hour = @contract.wednesday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)     
        when "Thursday"
          number_of_shift_per_day = @contract.total_hour_thursday
          @i = 0
          start_hour = @contract.thursday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)            
        when "Friday"
          number_of_shift_per_day = @contract.total_hour_friday
          @i = 0
          start_hour = @contract.friday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)      
        when "Saturday"
          number_of_shift_per_day = @contract.total_hour_saturday
          @i = 0
          start_hour = @contract.saturday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)      
        when "Sunday"
          number_of_shift_per_day = @contract.total_hour_sunday
          @i = 0
          start_hour = @contract.sunday_start_hour + (@i * 3600) 
          loop_monitoring_shift(date, number_of_shift_per_day, @contract, start_hour)
        end                                  
        if date + @d == @contract.end_date
          break
        end  
        @d += 1                    
      end      
      redirect_to contract_path(@contract)
    else
      render 'new'
    end
  end

  def loop_monitoring_shift(date, number_of_shift_per_day, contract, start_hour)               
    loop do               
      @monitoring_shift = MonitoringShift.new(date: date + @d, start_hour: start_hour + (@i * 3600), duration: 1, week_number: (date + @d).strftime('%W').to_i, contract_id: @contract.id)
      @monitoring_shift.end_hour = @monitoring_shift.start_hour + 3600
      @monitoring_shift.save!
      User.where(dev: true).each do |user|
        @user_monitoring_shift = UserMonitoringShift.new(user_id: user.id, monitoring_shift_id: @monitoring_shift.id)
        @user_monitoring_shift.save!
      end
      @i += 1
      if @i == number_of_shift_per_day
        break
      end             
    end
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(params_contract)
    authorize @contract
    redirect_to contract_path(@contract)
  end

  private
  def params_contract
    params.require(:contract).permit(:client_name, :start_date,:end_date, :monday_start_hour, :monday_end_hour, :tuesday_start_hour, :tuesday_end_hour, :wednesday_start_hour, :wednesday_end_hour, :thursday_start_hour, :thursday_end_hour, :friday_start_hour, :friday_end_hour, :saturday_start_hour, :saturday_end_hour, :sunday_start_hour, :sunday_end_hour, :price_per_hour)
  end

end
