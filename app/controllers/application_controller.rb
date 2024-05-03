class ApplicationController < ActionController::Base
    
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

  def check_token!
    if user = authenticate_with_http_token { |t, _| User.from_token(t) }
      @user = user
    else
      render json: {message: "Not authorized"}, status: 401
    end
  end
end
