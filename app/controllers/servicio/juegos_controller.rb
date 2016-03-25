class Servicio::JuegosController < Servicio::ServicioController
  
  def registrar
    juego = Juego.new params.permit(:nombre)
    resultado = {}
    if juego.save
      resultado[:mensaje] = "Juego guardado correctamente"
      resultado[:id] = juego.id
    else
      resultado[:mensaje] = "Juego no guardado"
    end
    resultado[:errores] = juego.errors.messages
    render json: resultado
  end
  
  def comprobar_nombre
    juego = Juego.new params.permit(:nombre)
    resultado = {}
    if juego.validate
      resultado[:mensaje] = "Se puede crear un juego con ese nombre"
    else
      resultado[:mensaje] = "No se puede crear un juego con ese nombre"
    end
    resultado[:errores] = juego.errors.messages
    render json: resultado    
  end

end
