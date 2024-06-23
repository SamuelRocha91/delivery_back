class PasswordsController < Devise::PasswordsController
  respond_to :json, :html

  def create
    self.resource = resource_class.find_or_initialize_with_errors(reset_password_keys, resource_params, :not_found)
    if resource.persisted?
      resource.send_reset_password_instructions
    end

    respond_with(resource, location: after_sending_reset_password_instructions_path_for(resource_name))
  end

  # GET /users/password/new
  def new
    super
  end

  # POST /users/password/reset
  def update
    super
  end

  private

  def resource_params
    params.require(resource_name).permit(:email)
  end

  def reset_password_keys
    [:email]
  end
end
