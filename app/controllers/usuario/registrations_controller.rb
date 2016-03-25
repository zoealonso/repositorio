class Usuario::RegistrationsController < Devise::RegistrationsController
  
  layout 'inicio', :except => [:edit, :update, :destroy]

  def create
    
    usuario = Usuario.new params.require(:usuario).permit(:email, :nombre, :password, :password_confirmation)
    self.resource = usuario
    
    usuario.save
    yield usuario if block_given?
    puts usuario.persisted?
    puts YAML::dump(usuario.errors)
    if usuario.persisted?
      if usuario.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, usuario)
        respond_with usuario, location: after_sign_up_path_for(usuario)
      else
        set_flash_message :notice, :"signed_up_but_#{usuario.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with usuario, location: after_inactive_sign_up_path_for(usuario)
      end
    else
      clean_up_passwords usuario
      set_minimum_password_length
      respond_with usuario
    end
  end
  
  def destroy
    clave = params.fetch(:password, '')
    if (current_usuario.valid_password? clave)
      super
    else
      @falta_confirmacion = 'La clave introducida no es válida'
      render :edit
    end
  end

  
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
