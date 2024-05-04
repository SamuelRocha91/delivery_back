class OrdersController < ApplicationController 
  skip_forgery_protection
  before_action :authenticate!
end
