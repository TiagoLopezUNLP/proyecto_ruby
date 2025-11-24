json.extract! imagen, :id, :url, :producto_id, :created_at, :updated_at
json.url imagen_url(imagen, format: :json)
