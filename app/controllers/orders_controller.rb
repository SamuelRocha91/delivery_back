class OrdersController < ApplicationController 
  include ActionController::Live
  skip_forgery_protection
  before_action :authenticate!
  before_action :set_locale!
  before_action  :only_buyers!, except: [:index, :show, :accept, :cancel, :start_progress, :ready_for_delivery, :start_delivery, :deliver], if: :json_request?
  before_action :set_order, only: [:pay, :show, :accept, :cancel, :start_progress, :ready_for_delivery, :start_delivery, :deliver]
  rescue_from User::InvalidToken, with: :not_authorized

  def index
    if request.format.json? && current_user.buyer?
      page = params.fetch(:page, 1)
      offset = (12 * (page.to_i - 1))
      @orders = Order.where(buyer: current_user).where(state: [:canceled, :delivered, :payment_failed])
      @orders = @orders.page(page).offset(offset)
    elsif request.format.json?
      page = params.fetch(:page, 1)
      offset = (10 * (page.to_i - 1))
      @orders = Order.where(store_id: params[:store_id]).includes(:order_items)
      if params[:created_at].present?
        date = Date.parse(params[:created_at])
        @orders = @orders.where('created_at >= ?', date)
      end
      if params[:status].present?
        @orders = @orders.where(state: params[:status])
      else
        @orders = @orders.where(state: [:canceled, :in_delivery, :delivered])
      end
      @orders = @orders.page(page).offset(offset)
    else
      @orders = Order.all
      @orders = @orders.where(state: params[:state]) if params[:state].present?
      @orders = @orders.page(params[:page]).per(10)
    end
  end

  def new
    @order = Order.new
    @order.order_items.build
    @users = User.kept.where(role: :buyer)
    @stores = Store.kept.where(is_open: true)
    @nonce = request.content_security_policy_nonce
  end

  def create

    if json_request?  
      @order = Order.new(order_params)
      @order.buyer = current_user
      if @order.save
        render json: {order: @order}, status: :created
      else
        render json: {errors: @order.errors}, status: :unprocessable_entity
      end
    else 
      @order = Order.new(store_id: order_params[:store_id], buyer_id: order_params[:buyer_id], order_items_attributes: [order_params[:order_items_attributes]])
      if @order.save
        flash[:notice] = "Pedido criado com sucesso"
        redirect_to orders_path
      else
        flash[:notice] = "Pedido não foi criado parça"
        redirect_to orders_path
      end
    end
  end

  def last_three
    @orders = Order.joins(:order_items)
               .where(buyer_id: current_user.id)
               .where(state: :delivered)
               .select('orders.*, order_items.product_id')
               .distinct
               .order(created_at: :desc)
               .limit(3)
    render json: @orders
  end

  def stream
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE.new(response.stream, retry: 300, event: "waiting-orders")
    begin
      sse.write({ hello: "world!"}, event: "waiting-order")
      EventMachine.run do
        EventMachine::PeriodicTimer.new(3) do
        orders = Order.where(buyer_id: current_user.id)
              .where.not(state: [:canceled, :delivered, :payment_failed])
           if orders.any?
            message = { time: Time.now, orders: orders } 
            sse.write(message, event: "new orders")
           else
            sse.write({ message: "no orders" }, event: "no")
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
    @store = @order.store
    @buyer = @order.buyer
    @order_items = @order.order_items
    if request.format.json?
      if @order
        render json: order_json(@order), status: :ok 
      else
        render json: { error: "Pedido não encontrado" }, status: :not_found #
      end
    end
  end

  def show_pay
    @order = Order.find(params[:id])
    @nonce = request.content_security_policy_nonce
  end

  def pay
    PaymentJob.perform_later(order: @order, value: payment_params[:value],number: payment_params[:number],valid: payment_params[:valid],cvv: payment_params[:cvv])
    if json_request?
      render json: { message: 'Payment processing started' }, status: :ok
    else
      flash[:notice] = "Pagamento sendo processado"
      redirect_to orders_path
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def accept
    if request.format.json?
      if @order.confirm!
        render json: { message: "Pedido aceito com sucesso", order: @order }, status: :ok
      else
        render json: { error: "Não foi possível aceitar o pedido" }, status: :unprocessable_entity
      end
    else
      @order.confirm!
      flash[:notice] = "Pedido aceito com sucesso"
      redirect_to orders_path(@order)
    end
  end

  def cancel
    if request.format.json?
      if @order.cancel!
        render json: { message: "Pedido cancelado", order: @order }, status: :ok
      else
        render json: { error: "Não foi possível cancelar o pedido" }, status: :unprocessable_entity
      end
    else
      @order.cancel!
      redirect_to orders_path(@order), notice: "Pedido cancelado"
    end
  end

  def start_progress
    if request.format.json?
      if @order.start_progress!
        render json: { message: "Pedido está sendo preparado", order: @order }, status: :ok
      else
        render json: { error: "Não foi possível alterar o pedido pro estado de preparo" }, status: :unprocessable_entity
      end
    else
      @order.start_progress!
      redirect_to orders_path(@order), notice: "Pedido está sendo preparado"
    end
  end

  def ready_for_delivery
    if request.format.json?
      if @order.ready_for_delivery!
        render json: { message: "Pedido pronto para entrega", order: @order }, status: :ok
      else
        render json: { error: "Não foi possível alterar o pedido pro estado de entrega" }, status: :unprocessable_entity
      end
    else
      @order.ready_for_delivery!
      redirect_to orders_path(@order), notice: "Pedido pronto para entrega"
    end
  end

  def start_delivery
    if request.format.json?
      @order.start_delivery!
      render json: @order
    else
      @order.start_delivery!
      redirect_to orders_path(@order), notice: "Pedido está sendo entregue"
    end
  end

  def deliver
    if request.format.json?
      @order.deliver!
      render json: @order
    else
      @order.deliver!
      redirect_to orders_path(@order), notice: "Pedido entregue"
    end
  end

  private

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end

  def order_params
    params.require(:order).permit(:store_id, :buyer_id, order_items_attributes: [ :product_id, :amount, :price])
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

  def set_order
    @order = Order.find(params[:id])
  end

end
