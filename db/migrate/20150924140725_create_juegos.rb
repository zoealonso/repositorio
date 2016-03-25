class CreateJuegos < ActiveRecord::Migration
  def change
    create_table :juegos do |t|
      t.string :nombre
    end
    add_index :juegos, :nombre, unique: true
  end
end
