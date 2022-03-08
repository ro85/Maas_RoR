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
    7.times { @contract.weekday_setups.build }
    authorize @contract
  end

  def create
    raise

  end

end
