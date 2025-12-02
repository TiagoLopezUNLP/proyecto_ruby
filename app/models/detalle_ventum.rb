class DetalleVentum < ApplicationRecord
  belongs_to :ventum, foreign_key: 'venta_id' 
  belongs_to :producto

  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :precio_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_save :calcular_subtotal

  def calcular_subtotal
    self.subtotal = precio_unitario * cantidad
  end
end
