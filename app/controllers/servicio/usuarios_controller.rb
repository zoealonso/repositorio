class Servicio::UsuariosController < Servicio::ServicioController
 
  def registrar
    usuario = Usuario.new params.permit(:email, :password, :nombre)
    juego_id = params.require(:juego_id)
    resultado = {}
    ActiveRecord::Base.transaction do
      if usuario.save
        resultado[:info] = genera_token juego_id, usuario.id
        resultado[:mensaje] = 'Usuario guardado'
      else
        resultado[:mensaje] = 'Usuario NO guardado'
      end
      resultado[:errores] = usuario.errors.messages
      render json: resultado
    end
  end
  
  def login
    usuario = Usuario.new params.permit(:email, :password)
    juego_id = params.require(:juego_id)
    usuario_bd = Usuario.find_by_email(usuario.email)
    valido = false
    if usuario_bd != nil
      valido = usuario_bd.valid_password?(usuario.password)
    end
    
    resultado = {}
    if valido
      resultado[:info] = genera_token juego_id, usuario_bd.id
      resultado[:mensaje] = 'Usuario logeado'
      errores = {}
    else
      resultado[:mensaje] = 'Usuario NO logueado'
      errores = {:email => ['Email o password no validos']}
    end
    resultado[:errores] = errores
    render json: resultado
  end
  
  private
  
  def genera_token juego_id, usuario_id
    
    TokenAcceso.delete_all :juego_id => juego_id, :usuario_id => usuario_id
    
    tokenAcceso = TokenAcceso.generar juego_id, usuario_id
    tokenAcceso.save
        
#      resultado = {}
#      resultado[:token] = token
#      resultado[:usuario_id] = usuario_id
      
#      resultado = {
#        token: tokenAcceso.token,
#        usuario_id: usuario.id
#      }
        
    {
      :token => tokenAcceso.token,
      :usuario_id => usuario_id
    }
    
  end

end
