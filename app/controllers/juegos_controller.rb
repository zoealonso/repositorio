class JuegosController < ApplicationController
  
    before_filter :authenticate_usuario!

  
  ##
  # Permite obtener todos los juegos registrados en la aplicación. Los
  # juegos se muestran ordenados por popularidad y paginados.
  #
  # * <tt>pagina</tt> - Página a mostrar. Si no se incluye se mostrará la primera.
  
  def index
    
    @pagina = params.fetch(:pagina, 1).to_i
    @juegos = Juego.pagina_todos(@pagina)
    @paginas = Juego.paginas_todos
    
  end
  
  ##
  # Permite obtener todos los juegos asociados al usuario logueado.
  # Se muestran en orden alfabético y paginados.
  #
  # * <tt>pagina</tt> - Página a mostrar. Si no se incluye se mostrará la primera.
  
  def mis_juegos
    
    @pagina = params.fetch(:pagina, 1).to_i
    @juegos = Juego.pagina_por_usuario(current_usuario, @pagina)
    @paginas = Juego.paginas_por_usuario(current_usuario)
  
  end
  
  ##
  # Permite obtener todos los juegos que contienen el texto escrito.
  # Se mostrarán en orden alfabético y paginados.
  # * <tt>pagina</tt> - Página a mostrar. Si no se incluye se mostrará la primera
  # * <tt>nombre</tt> - Nombre por el que se realiza la búsqueda.
  
  def buscar
    
    @pagina = params.fetch(:pagina, 1).to_i
    @nombre = params.fetch(:nombre, '')
    @juegos = Juego.pagina_buscar(@pagina, @nombre)
    @paginas = Juego.paginas_buscar(filtro)
    render :index    
  end
end
