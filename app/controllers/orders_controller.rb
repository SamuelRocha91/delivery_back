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

   def show
    @order = current_user.orders.includes(:order_items).find(params[:id])
    render json: order_json(@order), status: :ok 
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Pedido não encontrado" }, status: :not_found #
  end

  def pay
    order = Order.find(params[:id])
    PaymentJob.perform_later(order: order, value: payment_params[:value],number: payment_params[:number],valid: payment_params[:valid],cvv: payment_params[:cvv])
    render json: { message: 'Payment processing started' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def confirm_payment
    @order.confirm_payment!
    render json: @order
  end

  def confirm_payment
    @order.payment_failed!
    render json: @order
  end

  def accept
    @order.accept!
    render json: @order
  end

  def cancel
    @order.cancel!
    render json: @order
  end

  def start_progress
    @order.start_progress!
    render json: @order
  end

  def ready_for_delivery
    @order.ready_for_delivery!
    render json: @order
  end

  def start_delivery
    @order.start_delivery!
    render json: @order
  end

  def deliver
    @order.deliver!
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

  def order_json(order)
    {
      id: order.id,
      status: order.state,
      items: order.order_items.map do |item|
        {
          product: item.product.title,
          amount: item.amount,
          price: item.price
        }
      end,
      total: calculate_total(order)
    }
  end

   def calculate_total(order)
    order.order_items.sum { |item| item.price * item.amount }
  end
end
