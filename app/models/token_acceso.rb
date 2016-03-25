class TokenAcceso < ActiveRecord::Base

  CARACTERES = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
  
  belongs_to :usuario
  belongs_to :juego

  ##
  # Permite generar un token de acceso de manera aleatoria.
  # Se asociará a un juego y un usuario.
  #
  # * <tt>juego_id</tt> - Id del juego al que asociar el token.
  # * <tt>usuario_id</tt> - Id del usuario al que asociar el token.
  
  def self.generar(juego_id, usuario_id)

    token = TokenAcceso.new
    token.juego_id = juego_id
    token.usuario_id = usuario_id

    r = Random.new
    token.token = Array.new(250) { CARACTERES[r.rand(CARACTERES.length)] }.join
    
    token
    
  end

end
