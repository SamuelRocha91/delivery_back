class ProductsController < ApplicationController
    
  before_action :authenticate_user!
  
  def listing
      if !current_user.admin?
        redirect_to root_path
      end
      @products = Product.includes(:store)
    end
end
