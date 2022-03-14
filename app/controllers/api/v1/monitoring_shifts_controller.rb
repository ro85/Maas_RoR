class Api::V1::MonitorinShiftsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_monitoring_shift, only: [ :show, :update ]

  def update
    if @monitoring_shift.update(monitoring_shift_params)
      render :show
    else
      render_error
    end
  end

  private

  def monitoring_shift_params
    params.require(:monitoring_shift).permit(:name, :address)
  end

  def render_error
    render json: { errors: @monitoring_shift.errors.full_messages },
      status: :unprocessable_entity
  end
end