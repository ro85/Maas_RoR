class WeekdaySetupsController < ApplicationController

  def update
    @weekday_setup = WeekdaySetup.find(params[:id])
    @contract = Contract.find(params[:contract_id])
    @weekday_setup.update(params_weekday_setup)
    redirect_to contract_path(@contract)
    authorize @weekday_setup
  end

  private

  def params_weekday_setup
    params.require(:weekday_setup).permit(:start_of_monitoring, :end_of_monitoring)
  end
end
