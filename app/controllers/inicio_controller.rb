class InicioController < ApplicationController
  
  def inicio
  
    if usuario_signed_in?
      redirect_to :juegos
    else
      redirect_to :new_usuario_session
    end
    
  end
  
end
