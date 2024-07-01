class RegistrationsController < ApplicationController
  skip_forgery_protection only: [:create, :sign_in, :me, :deactivate_user]
  before_action :authenticate!, except: [:sign_in, :create, :refresh]
  rescue_from User::InvalidToken, with: :not_authorized

  def index
    @users = User.all  
  end

  def me
    if request.format == Mime[:json]
      @user = User.find(current_user[:id])
      @user = @user.as_json(include: :address)
      render json: @user
    else 
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if request.format == Mime[:json]
      if @user.update(user_params_update)
        render json: { message: "User successfully updated." }, status: :ok
      else
        render json: { message: "User not was successfully updated." }, status: :unprocessable_entity
      end
    else
      if @user.update(user_params_update)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render edit_registration_path, notice: 'User not was successfully updated.'
      end
    end
    
  end

  def sign_in
    access = current_credential.access
    user = User.kept.where(role: access).find_by(email: sign_in_params[:email])
    if !user || !user.valid_password?(sign_in_params[:password])
      render json: {message: "Nope!"}, status: 401
    else
      refresh_token = user.refresh_tokens.create!(expires_at: 30.days.from_now)
      token = User.token_for(user)
      render json: {email: user.email, token: token, refresh_token: refresh_token.refresh_token}
    end
  end

  def refresh
    refresh_token = RefreshToken.find_by(refresh_token: params[:refresh_token])
    if refresh_token && refresh_token.expires_at > Time.current
      user = refresh_token.user
      token = User.token_for(user)
      render json: {email: user.email, token: token, refresh_token: refresh_token.refresh_token}, status: :ok
    else
      render json: { error: 'Invalid or expired refresh token' }, status: :unauthorized
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

  def new
    @user = User.new
  end

  private

   def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation, 
      address_attributes: [:street, :number, :neighborhood, :city, :state, :postal_code])
  end

  def user_params_update
      params.require(:user).permit(:email, :role, 
      address_attributes: [:street, :number, :neighborhood, :city, :state, :postal_code])
  end

  def sign_in_params
    params
      .required(:login)
      .permit(:email, :password)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, 
    address_attributes: [:street, :number, :neighborhood, :city, :state, :postal_code])
  end

  def not_authorized(e)
    render json: {message: "Nope!"}, status: 401
  end

  def distance_between_addresses
    address1 = Address.find(params[:address1_id])
    address2 = Address.find(params[:address2_id])

    distance = address1.distance_to(address2)

    render json: { distance: distance }
  end
end