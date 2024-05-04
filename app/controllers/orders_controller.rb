class OrdersController < ApplicationController 
  skip_forgery_protection
  before_action :only_buyers!, :authenticate!

  def create
    @order = order.new(order_params)
    @order.buyer = current_user
    if @order.save
      render json: {order: @order}
    else
      remder json: {errors: @order.errors, status: unprocessable_entity}
    end
  end

  private

  def order_params
    params.require(:order).permit([:store_id])
  end
end
