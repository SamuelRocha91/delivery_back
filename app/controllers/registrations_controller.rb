class RegistrationsController < ApplicationController
    
  skip_forgery_protection only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {"email": @user.email}
    end
  end

  private

  def user_params
    params
    .required(:user)
    .permit(:email, :password, :password_confirmation, :role)
  end

end