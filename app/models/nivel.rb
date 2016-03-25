class Nivel < ActiveRecord::Base

  ##
  # Permite obtener los niveles asociados a una puntuación.
  #
  # * <tt>puntuacion_id</tt> - Id de la puntuación para realizar la búsqueda.
  
  scope :por_puntuacion, ->(puntuacion_id) {
    where(:puntuacion_id => puntuacion_id)
    .order(:numero => :asc)
  }
end
