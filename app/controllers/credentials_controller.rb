class CredentialsController < ApplicationController
  before_action :set_credential, only: [:update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_developer!

  def index
    @credentials = Credential.all
    @new_credential = Credential.new
  end

  def create
    @credential = Credential.new(credential_params)
    access = credential_params[:access].to_sym
    if Credential.exists?(access: @credential.access)
      redirect_to root_path, alert: "#{@credential.access.capitalize} credential already exists."
    else
      if @credential = Credential.create_access(access)
        redirect_to root_path, notice: 'Credential was successfully created.'
      else
        render :new, alert: 'Failed to create credential.'
      end
    end
  end

  def update
    if @credential.update(key: SecureRandom.base64(20))
      redirect_to root_path, notice: 'Credential was successfully updated.'
    else
      @credentials = Credential.all
      @new_credential = @credential
      render :index
    end
  end

  def destroy
    @credential.destroy
    redirect_to root_path, notice: 'Credential was successfully destroyed.'
  end

  private

  def set_credential
    @credential = Credential.find(params[:id])
  end

  def credential_params
    params.require(:credential).permit(:access, :key)
  end

  def authorize_developer!
    unless developer?
      flash[:alert] = "Access denied. You must be a developer to access this resource."
      redirect_to root_path
    end
  end

end
