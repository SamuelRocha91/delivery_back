def index
    if request.format == Mime[:json]
      page = params.fetch(:page, 1)
      offset = buyer? ? (12 * (page - 1)) : (5 * (page - 1))
      if buyer?
        @products = Product.kept.includes(image_attachment: :blob)
          .where(store_id: params[:store_id])
          .where('product_available = ? OR quantity_in_stock > ?', true, 0)
      else
        @store.products.kept.includes(image_attachment: :blob)
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
