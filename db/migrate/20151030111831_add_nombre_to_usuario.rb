class AddNombreToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :nombre, :string
    add_index :usuarios, :nombre, :unique => true
  end
end
