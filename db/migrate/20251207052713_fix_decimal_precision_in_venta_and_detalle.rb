class FixDecimalPrecisionInVentaAndDetalle < ActiveRecord::Migration[8.1]
  def change
    # Cambiar precisión en tabla venta
    change_column :venta, :total, :decimal, precision: 10, scale: 2
    
    # Cambiar precisión en tabla detalle_venta
    change_column :detalle_venta, :precio_unitario, :decimal, precision: 10, scale: 2
    change_column :detalle_venta, :subtotal, :decimal, precision: 10, scale: 2
  end
end
