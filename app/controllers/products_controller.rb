class ProductsController < ApplicationController
    def listing
      @products = Product.includes(:store)
    end
end
