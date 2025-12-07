class Ventum < ApplicationRecord
  belongs_to :user
  has_many :detalle_ventas, class_name: 'DetalleVentum', foreign_key: 'venta_id', dependent: :destroy
  has_many :productos, through: :detalle_ventas

  scope :activas, -> { where(cancelada: false) }
  scope :canceladas, -> { where(cancelada: true) }

  def cancelar!
    return false if cancelada?
    
    ActiveRecord::Base.transaction do
      # Restaurar stock
      detalle_ventas.each do |detalle|
        producto = detalle.producto
        producto.update!(stock: producto.stock + detalle.cantidad)
      end
      
      # Marcar como cancelada
      update!(cancelada: true)
    end
  end

  def activa?
    !cancelada?
  end
end
