class Producto < ApplicationRecord
  enum :tipo, %i[vinilo cd]
  enum :estado, %i[nuevo usado]

  belongs_to :autor
  belongs_to :categoria, class_name: 'Categorium', foreign_key: 'categoria_id'
  has_many_attached :imagenes

  validates :nombre, presence: true
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_create :set_fecha_ingreso
  before_update :set_fecha_modificacion

  private
  
  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end
  
  def set_fecha_modificacion
    self.fecha_modificacion = Time.current
  end
end
