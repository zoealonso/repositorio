class AddJugadoresToJuego < ActiveRecord::Migration
  def change
    add_column :juegos, :jugadores, :integer
    add_index :juegos, :jugadores
  end
end
