class Ventum < ApplicationRecord
  belongs_to :user
  has_many :detalle_ventas, class_name: 'DetalleVentum', foreign_key: 'venta_id', dependent: :destroy
  has_many :productos, through: :detalle_ventas
end
