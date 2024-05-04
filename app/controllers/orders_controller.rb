class OrdersController < ApplicationController 
  skip_forgery_protection
  before_action :only_buyers!, :authenticate!
end
