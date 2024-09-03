class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_nonce

  def current_user
    if request.format == Mime[:json]
      @user
    else
      super
    end
  end

  def authenticate!
    if request.format == Mime[:json]
      check_token!
    else
      authenticate_user!
    end
  end

  def current_credential
    return nil if request.format != Mime[:json]
    Credential.find_by(key: request.headers["X-API-KEY"]) || Credential.new
  end

  private
   
  def set_nonce
    @nonce = SecureRandom.base64(16)
  end
  
  def set_locale!
    if params[:locale].present?
      I18n.locale = params[:locale]
    end
  end
  
  def check_token!
    if user = authenticate_with_http_token { |t, _| User.from_token(t) }
      @user = User.new(id: user[:id], role: user[:role], email: user[:email])
    else
      render json: {message: "Not authorized"}, status: 401
    end
  end

  def only_buyers!
      if !buyer?
       render json: { message: "Not authorized" }, status: :unauthorized
      end
  end

  def buyer?
    (current_user && current_user.buyer?) && current_credential.buyer?
  end

  def developer?
    (current_user && current_user.developer?)
  end

  protected

   def verified_request?
     if request.content_type == 'application/json'
       true
     else
       super
     end
   end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

end
