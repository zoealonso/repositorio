class Puntuacion < ActiveRecord::Base

  TAMANIO_PAGINA = 15
  belongs_to :usuario
  belongs_to :juego
  has_many :niveles, :dependent => :destroy
  
  ##
  # Permite obtener las mejores puntuaciones de un usuario ordenadas de forma descendente.
  #
  # * <tt>pagina</tt> - Página a mostrar. Si no se incluye se mostrará la primera.
  
  scope :mejores, ->(pagina) { order(:puntos => :desc)
      .limit(TAMANIO_PAGINA)
      .offset((pagina-1) * TAMANIO_PAGINA)
      .includes(:usuario)
      .all
    }

  ##
  # Permite obtener las puntuaciones de un juego
  #
  # * <tt>juego_id</tt> - Id del juego sobre el que se realiza la búsqueda.
  
  scope :por_juego, ->(juego_id){
    eager_load(:usuario)
    .where(:juego_id => juego_id)
  }
  
end
