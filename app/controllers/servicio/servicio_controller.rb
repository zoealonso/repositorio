class Servicio::ServicioController < ActionController::Base

  protect_from_forgery with: :null_session

  protected
  
  attr_reader :token_acceso
  
  def comprobar_token_acceso_filter
    
    @token_acceso = TokenAcceso.where(params.require(:token_acceso).permit(:token, :usuario_id)).first
    
    if @token_acceso != nil
      yield
    else
      render :plain => 'No autorizado', :status => :forbidden
    end
    
  end

end
