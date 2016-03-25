class NivelesController < ApplicationController

  before_filter :authenticate_usuario!


  ##
  # Permite obtener las puntuaciones por niveles.
  #
  # * <tt>puntuacion_id</tt> - Id de la puntuación asociada al nivel.
  
  def index
    @puntuacion = Puntuacion.find params.require(:puntuacion_id)
    @niveles = Nivel.por_puntuacion @puntuacion.id
  end
  
end
