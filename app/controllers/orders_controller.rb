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

  def pay
    @order = Order.find(params[:id])
    PaymentJob.perform_later(order: @order, value: payment_params[:value],number: payment_params[:number],valid: payment_params[:valid],cvv: payment_params[:cvv])
    render json: { message: 'Payment processing started' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def confirm_payment
    @order.confirm_payment!
    notify_users(@order, "Payment confirmed")
    render json: @order
  end

  def confirm_payment
    @order.payment_failed!
    notify_users(@order, "Payment failed")
    render json: @order
  end

  def accept
    @order.accept!
    notify_users(@order, "Order accepted")
    render json: @order
  end

  def cancel
    @order.cancel!
    notify_users(@order, "Order canceled")
    render json: @order
  end

  def start_progress
    @order.start_progress!
    notify_users(@order, "Order in progress")
    render json: @order
  end

  def ready_for_delivery
    @order.ready_for_delivery!
    notify_users(@order, "Order ready for delivery")
    render json: @order
  end

  def start_delivery
    @order.start_delivery!
    notify_users(@order, "Order out for delivery")
    render json: @order
  end

  def deliver
    @order.deliver!
    notify_users(@order, "Order delivered")
    render json: @order
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

  def payment_params
    params.require(:payment).permit(:value, :number, :valid, :cvv)
  end

  def notify_users(order, message)
    buyer = User.find(order.buyer_id)
    store = User.find(order.store_id)
    OrdersChannel.notify_user(buyer, order, message)
    OrdersChannel.notify_user(store, order, message)
  end
end
