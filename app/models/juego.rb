class Juego < ActiveRecord::Base
  
  JUEGOS_POR_PAGINA = 10
  
  has_many :token_accesos
  has_many :puntuaciones

  validates :nombre, uniqueness: true
  
  ##
  # Permite obtener todos los juegos por orden de popularidad y paginados.
  # 
  # * <tt>numero</tt> - Número de página a mostrar. Si no se incluye de muestra la primera.
  
  scope :pagina_todos, ->(numero) {
    order(:jugadores => :desc)
    .limit(JUEGOS_POR_PAGINA)
    .offset((numero - 1) * JUEGOS_POR_PAGINA)
  }
  
  ##
  # Permite obtener los juegos por el id del usuario.
  #
  # * <tt>usuario</tt> - Usuario para buscar sus juegos asociados.
  
  scope :por_usuario, ->(usuario) {
    joins(:token_accesos)
    .merge(TokenAcceso.where(:usuario_id => usuario.id))
  }
  
  ##
  # Permite obtener una página con los juegos de un usuario ordenados alfabéticamente. 
  # 
  # * <tt>usuario</tt> - Usuario para buscar sus juegos asociados.
  # * <tt>numero</tt> - Número de página a mostrar. Si no se incluye se muestra la primera.
  
  scope :pagina_por_usuario, ->(usuario, numero) {
    por_usuario(usuario)
    .order(:nombre => :asc)
    .limit(JUEGOS_POR_PAGINA)
    .offset((numero - 1) * JUEGOS_POR_PAGINA)
  }
  
  ##
  # Permite buscar todos los juegos que contengan una cadena.
  #
  # * <tt>nombre</tt> - Nombre por el que se realiza la búsqueda. 
  
  scope :buscar, ->(nombre) {
    where('nombre LIKE ?', '%' + nombre + '%')
  }
  
  ##
  # Permite obtener una página con los juegos que contengan el nombre buscado.
  # Se mostrarán por orden de popularidad.
  #
  # * <tt>numero</tt> - Número de página a mostrar. Si no se incluye se muestra la primera.
  # * <tt>nombre</tt> - Nombre por el que se realiza la búsqueda.
  
  scope :pagina_buscar, ->(numero, nombre) {
    buscar(nombre)
    .order(:jugadores => :desc)
    .limit(JUEGOS_POR_PAGINA)
    .offset((numero - 1) * JUEGOS_POR_PAGINA)
  }

  ##
  # Permite obtener el número de páginas totales.

  def self.paginas_todos
    ((count - 1) / JUEGOS_POR_PAGINA) + 1
  end

  ## 
  # Permite obtener el número de páginas totales al realizar una búsqueda.
  #
  # * <tt>nombre</tt> - Nombre por el que se realiza la búsqueda.
  
  def self.paginas_buscar(nombre)
    ((buscar(nombre).count - 1) / JUEGOS_POR_PAGINA) + 1
  end

  ##
  # Permite obtener el número de páginas totales para los juegos del usuario logueado.
  #
  # * <tt>usuario</tt> - Usuario para buscar sus juegos asociados.
  
  def self.paginas_por_usuario(usuario)
    ((por_usuario(usuario).count - 1) / JUEGOS_POR_PAGINA) + 1
  end
  
  ##
  # Permite obtener la mejor puntuación.
  
  def mejor_puntuacion
    puntuaciones.order('puntos DESC').eager_load(:usuario).first
  end
  
  ##
  # Permite obtener la mejor puntuación de un usuario.
  #
  # * <tt>usuario</tt> - Usuario sobre el que se realiza la consulta.
  
  def mejor_puntuacion_usuario(usuario)
    puntuaciones.where(:usuario_id => usuario.id).order('puntos DESC').eager_load(:usuario).first
  end
  
  ##
  # Permite obtener el ranking del usuario.
  #
  # * <tt>usuario</tt> - Usuario sobre el que se realiza la consulta.
  
  def posicion(usuario)
    Puntuacion.where(
        'puntos > ?',
        Puntuacion.where(:juego_id => id, :usuario_id => usuario.id).maximum(:puntos)
      ).count + 1
  end
end
