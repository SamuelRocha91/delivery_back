class RegistrationsController < ApplicationController
  skip_forgery_protection only: [:create, :sign_in, :me, :deactivate_user]
  before_action :authenticate!, except: [:sign_in, :create]
  rescue_from User::InvalidToken, with: :not_authorized

  def index
    @users = User.all  
  end

  def me
    if request.format == Mime[:json]
      render json:  {"email": current_user[:email], "id": current_user[:id] }
    else 
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render edit_registration_path, notice: 'User not was successfully updated.'
    end
  end

  def sign_in
    access = current_credential.access
    user = User.kept.where(role: access).find_by(email: sign_in_params[:email])

    if !user || !user.valid_password?(sign_in_params[:password])
      render json: {message: "Nope!"}, status: 401
    else
      token = User.token_for(user)
      render json: {email: user.email, token: token}
    end
  end

  def create
    if request.format == Mime[:json]
      @user = User.new(user_params)
      @user.role = current_credential.access
      if @user.save
        render json: {"email": @user.email}
      else
        render json: {}, status: :unprocessable_entity
      end
    else
      @user = User.new(sign_up_params)
      if @user.save
        redirect_to root_path, notice: 'User created successfully.'
      else
        render :new
      end
    end
  end

  def deactivate_user
    user = User.find(params[:id])
    if request.format == Mime[:json]
      if user.discard!
        render json: { message: "User successfully deactivated." }, status: :ok
      else
        render json: { message: "Failed to deactivate user." }, status: :unprocessable_entity
      end
    else
      if user.discard!
        redirect_to users_path, notice: 'User deactivate successfully.'
      else
        flash[:alert] = 'User not deactivated.'
        redirect_to users_path
      end
    end
  end

  def reactivate
    @user = User.find(params[:id])
    @user.undiscard 
    redirect_to users_path, notice: 'User reactivated successfully.'
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params
      .required(:user)
      .permit(:email, :password, :password_confirmation)
  end

  def user_params_update
    params
      .required(:user)
      .permit(:email, :role)
  end

  def sign_in_params
    params
      .required(:login)
      .permit(:email, :password)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end

end