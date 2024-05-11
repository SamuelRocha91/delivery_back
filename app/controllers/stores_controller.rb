class StoresController < ApplicationController
  before_action :authenticate!
  before_action :set_store, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  rescue_from User::InvalidToken, with: :not_authorized


  # GET /stores or /stores.json
  def index
    if current_user.admin?
      @stores = Store.all
    else
      @stores = Store.where(user: current_user)
    end
  end

  def new
    @store = Store.new
    if current_user.admin?
      @sellers = User.where(role: :seller)
    end
  end
  # GET /stores/1 or /stores/1.json
  def show
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores or /stores.json
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

  # PATCH/PUT /stores/1 or /stores/1.json
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

  # DELETE /stores/1 or /stores/1.json
  def destroy
    @store.destroy!

    respond_to do |format|
      format.html { redirect_to stores_url, notice: "Store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def store_params
      puts "Params received: #{params.inspect}"

      required = params.require(:store)

      if current_user.admin?
        required.permit(:name, :user_id, :avatar)
      else
        required.permit(:name, :avatar)
      end
    end

    def not_authorized(e)
      render json: {message: "Nope!"}, status: 401
    end
end
