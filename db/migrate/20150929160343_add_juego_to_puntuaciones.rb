class AddJuegoToPuntuaciones < ActiveRecord::Migration
  def change
    add_reference :puntuaciones, :juego, index: true, foreign_key: true
  end
end
