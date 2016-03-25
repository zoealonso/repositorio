require 'test_helper'

class JuegoTest < ActiveSupport::TestCase
  
  test "pagina_todos" do
    
    juegos = Juego.pagina_todos(1).all
    assert_equal 10, juegos.count

    juegos = Juego.pagina_todos(2).all
    assert_equal 5, juegos.count
    
  end
  
  test "buscar" do
    
    juegos = Juego.buscar('5').all
    assert_equal 2, juegos.count
    
  end

  test "pagina_buscar" do
    
    juegos = Juego.pagina_buscar(1, 'Juego').all
    assert_equal 10, juegos.count

    juegos = Juego.pagina_buscar(2, 'Juego').all
    assert_equal 5, juegos.count

  end
  
  test "por_usuario" do
    
    juegos = Juego.por_usuario(Usuario.find 1).all
    assert_equal 2, juegos.count

    juegos = Juego.por_usuario(Usuario.find 2).all
    assert_equal 8, juegos.count
    
  end
  
  test "pagina_por_usuario" do
    
    juegos = Juego.pagina_por_usuario(Usuario.find(2), 1).all
    assert_equal 8, juegos.count
    
  end
  
  test "paginas_todos" do
    
    paginas = Juego.paginas_todos
    assert_equal 2, paginas

  end


  test "paginas_buscar" do
    
    paginas = Juego.paginas_buscar 'Juego'
    assert_equal 2, paginas

  end

  test "paginas_por_usuario" do
    
    paginas = Juego.paginas_por_usuario(Usuario.find(2))
    assert_equal 1, paginas

  end
  
  test "mejor_puntuacion" do
    
    juego = Juego.find 1
    mejor = juego.mejor_puntuacion
    assert_equal 2, mejor.id
    
  end

  test "mejor_puntuacion_usuario" do
    
    juego = Juego.find 1
    mejor = juego.mejor_puntuacion_usuario(Usuario.find 1)
    assert_equal 3, mejor.id
    
  end  

  test "posicion" do
    
    juego = Juego.find 1
    posicion = juego.posicion(Usuario.find 1)
    assert_equal 2, posicion
    
  end  

end
