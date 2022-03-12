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
    @total_hs = []
    @contract.weekday_setups.each do |weekday_setup|
      @total_hs << ((weekday_setup.end_of_monitoring.to_time.to_i - weekday_setup.start_of_monitoring.to_time.to_i).abs/60/60)
    end
    authorize @contract
  end

  def new
    @contract = Contract.new
    @weekdays = Weekday.all
    @weekday_setup = WeekdaySetup.new
    authorize @contract
    
  end

  def create
    @contract = Contract.new(params_contract)      
    
    if @contract.save!
      authorize @contract
      User.where(admin: false).each do |user|
        date = @contract.start_date.to_date    
        d = 0     
        loop do    
          d += 1      
          case (date + d).strftime('%A')
          when "Monday"
            number_of_shift_per_day = (@contract.monday_end_hour.to_time.to_i - @contract.monday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.monday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%W').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end            
              
            end
          when "Tuesday"
            number_of_shift_per_day = (@contract.tuesday_end_hour.to_time.to_i - @contract.tuesday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.tuesday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          when "Wednesday"
            number_of_shift_per_day = (@contract.wednesday_end_hour.to_time.to_i - @contract.wednesday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.wednesday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          when "Thursday"
            number_of_shift_per_day = (@contract.thursday_end_hour.to_time.to_i - @contract.thursday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.thursday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          when "Friday"
            number_of_shift_per_day = (@contract.friday_end_hour.to_time.to_i - @contract.friday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.friday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          when "Saturday"
            number_of_shift_per_day = (@contract.saturday_end_hour.to_time.to_i - @contract.saturday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.saturday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          when "Sunday"
            number_of_shift_per_day = (@contract.sunday_end_hour.to_time.to_i - @contract.sunday_start_hour.to_time.to_i)/60/60
            start_hour = @contract.sunday_start_hour
            i = 0
            loop do
              i += 1 
              @monitoring_shift = MonitoringShift.new(user_id: user.id, date: date, start_hour: start_hour + (i * 3600), end_hour: start_hour.to_time + 3600, duration: 1, week_number: date.strftime('%U').to_i, contract_id: @contract.id)
              @monitoring_shift.save!
              start_hour += 3600
              if i == number_of_shift_per_day
                break
              end 
            end      
          end
        
          
          date += 1
          if date == @contract.end_date
            break
          end
        end
      end
    








      redirect_to contract_path(@contract)
    else
      render 'new'
    end
    

  end

  private
  def params_contract
    params.require(:contract).permit(:client_name, :start_date,:end_date, :monday_start_hour, :monday_end_hour, :tuesday_start_hour, :tuesday_end_hour, :wednesday_start_hour, :wednesday_end_hour, :thursday_start_hour, :thursday_end_hour, :friday_start_hour, :friday_end_hour, :saturday_start_hour, :saturday_end_hour, :sunday_start_hour, :sunday_end_hour)
  end

end