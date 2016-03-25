class CreateNiveles < ActiveRecord::Migration
  def change
    create_table :niveles do |t|
      t.integer :numero
      t.integer :puntos
    end
  end
end
