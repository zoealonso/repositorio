class CreateTokenAccesos < ActiveRecord::Migration
  def change
    create_table :token_accesos do |t|
      t.string :token
      t.references :usuario, index: true, foreign_key: true
      t.references :juego, index: true, foreign_key: true
    end
  end
end
