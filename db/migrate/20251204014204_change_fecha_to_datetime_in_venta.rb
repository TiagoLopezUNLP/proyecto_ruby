class ChangeFechaToDatetimeInVenta < ActiveRecord::Migration[8.1]
  def change
    change_column :venta, :fecha, :datetime
  end
end
