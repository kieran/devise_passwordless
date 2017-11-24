class Devise::PasswordlessController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :show, :create]

  if respond_to? :helper_method
    helper_method :after_sign_in_path_for
  end

  # GET /resource/passwordless/new
  def new
    self.resource = resource_class.new
    render :new
  end

  # POST /resource/passwordless
  def create
    resource = resource_class.where(email: params[:user][:email]).first

    resource.create_passwordless_token!

    Devise.mailer.passwordless_token(resource).deliver!

    set_flash_message :notice, :check_your_email

    # respond_with_navigational(resource) { render :new }
    redirect_to '/'
  end

  # GET /resource/passwordless/:id
  def show
    resource_from_passwordless_token
    return unless resource.present?

    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
    redirect_to after_sign_in_path_for(resource)
  end

  protected

  def resource_from_passwordless_token
    unless params[:token] && self.resource = resource_class.passwordless_token_valid.where(passwordless_token:params[:token]).first
      set_flash_message(:alert, :passwordless_token_invalid) if is_flashing_format?
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

end
