class RegistrationsController < ApplicationController
    
  skip_forgery_protection only: [:create, :sign_in, :me]
  before_action :authenticate!, only: [:me]
  rescue_from User::InvalidToken, with: :not_authorized


  def me
    render json:  {"email": current_user[:email], "id": current_user[:id] }
  end

  def sign_in
    user = User.find_by(email: sign_in_params[:email])

    if !user || !user.valid_password?(sign_in_params[:password])
      render json: {message: "Nope!"}, status: 401
    else
      token = User.token_for(user)
      render json: {email: user.email, token: token}
    end
  end

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
      .permit(:email, :password, :password_confirmation)
  end

  def sign_in_params
    params
      .required(:login)
      .permit(:email, :password)
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end
end