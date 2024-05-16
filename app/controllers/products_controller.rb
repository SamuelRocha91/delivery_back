class ProductsController < ApplicationController  
  before_action :authenticate!
  before_action :set_product, only: %i[ show edit update destroy ]
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

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    required = params.require(:product).permit(:tile, :price, :description, :image, :category)
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end
end

