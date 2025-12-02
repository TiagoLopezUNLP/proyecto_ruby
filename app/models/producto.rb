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

  scope :activos, -> { where(fecha_baja: nil) }
  scope :eliminados, -> { where.not(fecha_baja: nil) }
  
  # Definir atributos buscables para Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["nombre", "descripcion", "precio", "stock", "tipo", "estado", "autor_id", "categoria_id", "created_at", "updated_at"]
  end

  # Definir asociaciones buscables para Ransack
  def self.ransackable_associations(auth_object = nil)
    ["autor", "categoria"]
  end
  
  private
  
  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end
  
  def set_fecha_modificacion
    self.fecha_modificacion = Time.current
  end
end
