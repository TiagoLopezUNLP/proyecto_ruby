json.extract! producto, :id, :nombre, :descripcion, :precio, :stock, :fecha_ingreso, :fecha_modificacion, :fecha_baja, :tipo, :estado, :autor_id, :categoria_id, :created_at, :updated_at
json.url producto_url(producto, format: :json)
