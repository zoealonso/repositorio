class CreatePuntuaciones < ActiveRecord::Migration
  def change
    create_table :puntuaciones do |t|
      t.string :puntos
      t.references :usuario, index: true, foreign_key: true
    end
  end
end
