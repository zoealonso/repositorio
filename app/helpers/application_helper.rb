module ApplicationHelper

  def clase_error(modelo, campo)
    modelo.errors.include?(campo) ? 'has-error' : ''
  end
  
  def errores(modelo, campo)
    
    salida = ''
    modelo.errors.full_messages_for(campo).each do |mensaje|
      salida += content_tag(:div, mensaje, :class => 'help-block').to_s
    end
    
    salida.html_safe
    
  end
  
end
