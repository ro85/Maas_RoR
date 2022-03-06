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

end
