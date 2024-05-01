class ProductsController < ApplicationController
    def listing
      @products = Product.all
    end
end
