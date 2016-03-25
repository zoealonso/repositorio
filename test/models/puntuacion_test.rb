require 'test_helper'

class PuntuacionTest < ActiveSupport::TestCase
  
  test "mejores" do
    
    puntuaciones = Puntuacion.mejores(1)
    assert_equal [20, 15, 10], puntuaciones.map { |p| p.puntos.to_i }
  end
  
  test "por_juego" do
    
    puntuaciones = Puntuacion.por_juego(1)
    assert_equal 3, puntuaciones.count
    
  end
  
end
