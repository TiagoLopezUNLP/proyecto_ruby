class Ventum < ApplicationRecord
  belongs_to :user
  has_many :detalle_ventas, dependent: :destroy
  has_many :productos, through: :detalle_venta
end
