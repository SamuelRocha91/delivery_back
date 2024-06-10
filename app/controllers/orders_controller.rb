class OrdersController < ApplicationController 
  include ActionController::Live
  skip_forgery_protection
  before_action :authenticate!
  before_action :set_locale!
  before_action  :only_buyers!, except: [:show, :accept, :cancel, :start_progress, :ready_for_delivery, :start_delivery, :deliver], if: :json_request?
  rescue_from User::InvalidToken, with: :not_authorized

   def index
    if request.format.json?
      page = params.fetch(:page, 1)
      offset = (12 * (page.to_i - 1))
      @orders = Order.where(buyer: current_user).where(state: [:canceled, :delivered, :payment_failed])
      @orders = @orders.page(page).offset(offset)  
    else
      @orders = Order.all
      @orders = @orders.where(state: params[:state]) if params[:state].present?
      @orders = @orders.page(params[:page]).per(10)
    end
  end

  def create
    @order = Order.new(order_params)
    @order.buyer = current_user
    if @order.save
      render json: {order: @order}, status: :created
    else
      render json: {errors: @order.errors}, status: :unprocessable_entity
    end
  end

  def stream
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE.new(response.stream, retry: 300, event: "waiting-orders")
    last_orders = nil
    begin
      sse.write({ hello: "world!"}, event: "waiting-order")
      EventMachine.run do
        EventMachine::PeriodicTimer.new(3) do
        orders = Order.where(buyer_id: current_user.id)
              .where.not(state: [:canceled, :delivered, :payment_failed])
         if orders != last_orders 
           if orders.any?
            message = { time: Time.now, orders: orders } 
            sse.write(message, event: "new orders")
           else
            sse.write({ message: "no orders" }, event: "no")
           end
           last_orders = orders 
         end
        end
      end
    rescue IOError, ActionController::Live::ClientDisconnected
      sse.close
    ensure
      sse.close
    end
  end

   def show
    @order = Order.includes(order_items: :product).find(params[:id])
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
    order = Order.find(params[:id])
    if order.confirm!
      render json: { message: "Pedido aceito com sucesso", order: order }, status: :ok
    else
      render json: { error: "Não foi possível aceitar o pedido" }, status: :unprocessable_entity
    end
  end

  def cancel
    order = Order.find(params[:id])
    order.cancel!
    render json: @order
  end

  def start_progress
    order = Order.find(params[:id])
    if order.start_progress!
      render json: { message: "Pedido está sendo preparado", order: order }, status: :ok
    else
      render json: { error: "Não foi possível alterar o pedido pro estado de preparo" }, status: :unprocessable_entity
    end
  end

  def ready_for_delivery
    order = Order.find(params[:id])
    if order.ready_for_delivery!
      render json: { message: "Pedido pronto para entrega", order: order }, status: :ok
    else
      render json: { error: "Não foi possível alterar o pedido pro estado de entrega" }, status: :unprocessable_entity
    end
  end

  def start_delivery
    @order.start_delivery!
    render json: @order
  end

  def deliver
    @order.deliver!
    render json: @order
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
    locale = params[:locale] || I18n.default_locale

    I18n.with_locale(locale) do
      {
        id: order.id,
        status: order.state,
        items: order.order_items.map do |item|
          {
            product: item.product.title,
            amount: item.amount,
             price: format_price(item.price)
          }
        end,
        total: format_price(calculate_total(order)) 
      }
    end
  end

  def format_price(price)
    ActionController::Base.helpers.number_to_currency(price)
  end

  def calculate_total(order)
    order.order_items.sum { |item| item.price * item.amount }
  end

  def json_request?
    request.format.json?
  end
end
