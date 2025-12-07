class AddCanceladaToVenta < ActiveRecord::Migration[8.1]
  def change
    add_column :venta, :cancelada, :boolean, default: false, null: false
  end
end
