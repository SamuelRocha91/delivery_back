class ProductsController < ApplicationController  
  before_action :authenticate!, except: [:listing_within_token] 
  before_action :set_locale!
  before_action :set_store, only: %i[show update destroy index edit new]
  before_action :set_product, only: %i[show edit]
  skip_forgery_protection 
  rescue_from User::InvalidToken, with: :not_authorized

  def index
    if request.format == Mime[:json]
      page = params.fetch(:page, 1).to_i
      offset = buyer? ? (12 * (page - 1)) : (5 * (page - 1))
      if buyer?
        @products = Product.kept.includes(image_attachment: :blob)
          .where(store_id: params[:store_id])
          .where('product_available = ? OR quantity_in_stock > ?', true, 0)
      else
        @products = @store.products.kept.includes(image_attachment: :blob)
      end
      @products = @products.where('LOWER(title) LIKE ?', "%#{params[:name]}%") if params[:name].present?
      @products = @products.where(category: params[:category]) if params[:category].present?
      if params[:order_by] == 'title'
        @products = @products.order(title: :asc)
      elsif params[:order_by] == 'price'
        @products = @products.order(price: :asc)
      else
        @products = @products.order(:title)
      end
      @products = @products.page(page).offset(offset)
    else
      @products = @store.products.includes(image_attachment: :blob)
    end
  end


  def new
    @product = @store.products.new
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
      if current_user.admin?
        @products = Product.all.includes(:store, :image_attachment)
      else
         redirect_to root_path, notice: "No permission for you"
      end
    end   
  end

  def listing_within_token
    page = params.fetch(:page, 1)
    offset = (12 * (page.to_i - 1))
    @products = Product.kept.includes(image_attachment: :blob)
      .where(store_id: params[:store_id]).order(:title)
    @products = @products.where('LOWER(title) LIKE ?', "%#{params[:name]}%") if params[:name].present?
    @products = @products.where(category: params[:category]) if params[:category].present?
    @products = @products.page(page).offset(offset)
  end

  def create
    @store = Store.find(params[:store_id])
    @product = @store.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to store_url(id: @store.id), notice: "Product was successfully created." }
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
     @product.discard!
     respond_to do |format|
       format.html { redirect_to listing_path, notice: "Product was successfully destroyed." }
       format.json { head :no_content}
     end
    end

  def reactivate
    @store = Store.find(params[:store_id])
    if @store.user.discarded? || @store.discarded?
      flash[:notice] = "Unprocessable entity."
      render :show, status: :unprocessable_entity
    else
      @product = @store.products.find(params[:id]).undiscard
      redirect_to listing_path, notice: 'Product reactivated successfully'
    end
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def product_params
    params.require(:product)
      .permit(:title, :price, :description, :image, :category, 
      :name, :product_available, :quantity_in_stock, :is_inventory_product )
  end

  def set_product
    @product =  @store.products.find_by(id: params[:id])
    if @product.nil?
      respond_to do |format|
        format.html { 
          redirect_to store_url(@store), 
          alert: "Product not found or has been discarded." 
        }
        format.json { 
          render json: { error: "Product not found or has been discarded" },
          status: :not_found 
        }
      end
    end
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end

end
