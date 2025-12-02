json.extract! detalle_ventum, :id, :venta_id, :producto_id, :cantidad, :precio_unitario, :subtotal, :created_at, :updated_at
json.url detalle_ventum_url(detalle_ventum, format: :json)
