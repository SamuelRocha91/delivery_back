class ProductsController < ApplicationController  
  before_action :authenticate!
  before_action :set_store, only: %i[show update destroy index edit]
  before_action :set_product, only: %i[show edit]

  skip_forgery_protection 
  rescue_from User::InvalidToken, with: :not_authorized

  def index
    render json: { data: @store.products.kept }, status: :ok
  end

  def listing
    if request.format == Mime[:json]
      if @user && @user.admin?
        @products = Product.kept.all
        render json: { message: "Success", data: @products}
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      if !current_user.admin?
        redirect_to root_path, notice: "No permision for you"
      else
        @products = Product.kept.includes(:store, :image_attachment)
      end
    end   
  end

 def create
    @store = Store.find(params[:store_id])
    @product = @store.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to store_url(@store), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: store_products_url(@store, @product) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @product = @store.products.kept.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to store_url(@store), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: store_product_url(@store, @product) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
     @product = @store.products.find(params[:id])
     @product.discard
     respond_to do |format|
       format.html { redirect_to store_products_url, notice: "Product was successfully destroyed." }
       format.json { head :no_content}
     end
  end

  private

  def set_store
      @store = Store.kept.find(params[:store_id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :image, :category)
  end

  def set_product
    @product =  @store.products.kept.find_by(id: params[:id])
    if @product.nil?
      respond_to do |format|
        format.html { redirect_to store_url(@store), alert: "Product not found or has been discarded." }
        format.json { render json: { error: "Product not found or has been discarded" }, status: :not_found }
      end
    end
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end
end

