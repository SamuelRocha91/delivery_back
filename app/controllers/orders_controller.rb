class OrdersController < ApplicationController 
  skip_forgery_protection
  before_action :authenticate!, :only_buyers!
  rescue_from User::InvalidToken, with: :not_authorized

  def create
    @order = Order.new(order_params)
    @order.buyer = current_user
    if @order.save
      render json: {order: @order}, status: :created
    else
      render json: {errors: @order.errors}, status: :unprocessable_entity
    end
  end

  def index
    @orders = Order.where(buyer: current_user)
  end

  private

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end

  def order_params
    params.require(:order).permit(:store_id, order_items_attributes: [ :product_id, :amount, :price])
  end
end
