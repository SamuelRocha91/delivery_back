class ProductsController < ApplicationController  
  before_action :authenticate!
  skip_forgery_protection 
  rescue_from User::InvalidToken, with: :not_authorized

  def listing
    if request.format == Mime[:json]
      if @user && @user.admin?
        @products = Product.all
        render json: { message: "Success", data: @products}
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      if !current_user.admin?
        redirect_to root_path, notice: "No permision for you"
      else
        @products = Product.includes(:store)
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


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    required = params.require(:product).permit(:title, :price, :description, :image, :category)
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end
end

