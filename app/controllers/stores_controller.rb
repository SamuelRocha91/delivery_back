class StoresController < ApplicationController
  include ActionController::Live

  before_action :authenticate!, except: %i[ listing ]
  before_action :set_store, only: %i[ show edit update destroy ]
  skip_forgery_protection 
  rescue_from User::InvalidToken, with: :not_authorized
  
  # GET /stores or /stores.json
  def index
    if request.format == Mime[:json]
      if current_user.admin? || current_user.buyer?
        page = params.fetch(:page, 1)
        @stores = Store.kept.includes(avatar_attachment: :blob).order(:name)
        @stores = @stores.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") if params[:name].present?

        @stores = @stores.where(category: params[:category]) if params[:category].present?
        @stores = @stores.page(page)
      else
        @stores = Store.kept.where(user: current_user).includes(avatar_attachment: :blob)
      end
    else
      @stores = Store.includes(avatar_attachment: :blob).includes(:user)
    end
  end

  def new_order
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE.new(response.stream, retry: 300, event: "waiting-orders")
    last_orders = nil
    begin
      sse.write({ hello: "world!"}, event: "waiting-order")
      EventMachine.run do
        EventMachine::PeriodicTimer.new(3) do
         orders = Order.where.not(state: [:canceled, :delivered, :payment_failed, :created, :payment_pending])
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

  def listing
    page = params.fetch(:page, 1)
    @stores = Store.kept.includes(avatar_attachment: :blob).order(:name)
    @stores = @stores.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") if params[:name].present?
    @stores = @stores.where(category: params[:category]) if params[:category].present?
    @stores = @stores.page(page)
  end

  def new
    @store = Store.new
    if current_user.admin?
      @sellers = User.kept.where(role: :seller)
    end
  end
  def show
  end

  def edit
  end

  def create
    @store = Store.new(store_params)
    if !current_user.admin?
      @store.user = current_user ? current_user : @user
    end


    respond_to do |format|
      if @store.save
        format.html { redirect_to store_url(@store), notice: "Store was successfully created." }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_url(@store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @store.discard!

    respond_to do |format|
      format.html { redirect_to stores_url, notice: "Store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def reactivate
    @store = Store.find(params[:id])
    if @store.user.discarded?
      flash[:notice] = "Unprocessable entity."
      render :show, status: :unprocessable_entity
    else
      @store.undiscard 
      redirect_to stores_path, notice: 'Store reactivated successfully.'
    end
  end

  private
    def set_store
      @store = Store.find(params[:id])

      if @store.nil?
        respond_to do |format|
          format.html { redirect_to store_url(@store), alert: "Store not found or has been discarded." }
          format.json { render json: { error: "Store not found or has been discarded" }, status: :not_found }
        end
      end
    end

    def store_params
      required = params.require(:store)
      if current_user.admin?
        required.permit(:name, :user_id, :avatar, :description, :category, :address, :state, :city, :cep, :number_address, :neighborhood, :cnpj, :is_open, :color_theme)
      else
        required.permit(:name, :avatar, :description, :category, :address, :state, :city, :cep, :number_address, :neighborhood, :cnpj, :is_open,  :color_theme)
      end
    end

    def not_authorized(e)
      render json: {message: "Nope!"}, status: 401
    end
end
