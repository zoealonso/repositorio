class AddPuntuacionToNiveles < ActiveRecord::Migration
  def change
    add_reference :niveles, :puntuacion, index: true, foreign_key: true
  end
end
