class PuntuacionesController < ApplicationController
  
    before_filter :authenticate_usuario!

  
  ##
  # Permite obtener todas las puntuaciones asociadas a un juego
  #
  # * <tt>juego_id</tt> - Id del juego para realizar la búsqueda.
  
  def index
    juego_id = params.require(:juego_id)
    @juego = Juego.find juego_id
    @puntuaciones = Puntuacion.por_juego juego_id
  end
end
