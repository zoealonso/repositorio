class Servicio::PuntuacionesController < Servicio::ServicioController
  
  around_filter :comprobar_token_acceso_filter
  
  def registrar
  
    puntuacion = Puntuacion.new params.permit(:puntos)
    puntuacion.usuario = token_acceso.usuario
    puntuacion.juego = token_acceso.juego
    
    params.require(:niveles).each do |nivel|
      puntuacion.niveles << Nivel.new(nivel.permit(:numero, :puntos))
    end
    
    puntuacion.save
  
    render :json => {
      :mensaje => 'Puntuación registrada',
      :errores => {}
    }
    
  end
  
  def mejores
    
    pagina = params.fetch('pagina', 0)
    
    mejores = []
    Puntuacion.mejores(pagina).each do |puntuacion|
      mejores << {
        :puntos => puntuacion.puntos,
        :nombre => puntuacion.usuario.nombre
      }
    end
    
    render :json => {
      :mensaje => 'Puntuaciones obtenidas',
      :info => mejores,
      :errores => {}
    }
    
  end
end
