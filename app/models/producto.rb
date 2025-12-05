class Producto < ApplicationRecord
  enum :tipo, %i[vinilo cd]
  enum :estado, %i[nuevo usado]

  belongs_to :autor
  belongs_to :categoria, class_name: 'Categorium', foreign_key: 'categoria_id'
  has_many_attached :imagenes
  has_one_attached :audio_muestra

  has_many :detalle_ventas
  has_many :ventas, through: :detalle_ventas

  validates :nombre, presence: true
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :release_year, numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.current.year }, allow_nil: true
  
  # Validaciones de Active Storage
  validates :imagenes, 
    content_type: { in: ['image/png', 'image/jpeg'], message: 'debe ser PNG, JPG o JPEG' },
    size: { less_than: 5.megabytes, message: 'debe ser menor a 5MB' },
    if: -> { imagenes.attached? }
  
  validates :audio_muestra,
    content_type: { in: ['audio/mpeg'], message: 'debe ser MP3' },
    size: { less_than: 10.megabytes, message: 'debe ser menor a 10MB' },
    if: -> { audio_muestra.attached? }
    
  before_create :set_fecha_ingreso
  before_update :set_fecha_modificacion

  scope :activos, -> { where(fecha_baja: nil) }
  scope :eliminados, -> { where.not(fecha_baja: nil) }
  
  # Definir atributos buscables para Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["nombre", "descripcion", "precio", "stock", "tipo", "estado", "autor_id", "categoria_id", "created_at", "updated_at", "release_year"]
  end

  # Definir asociaciones buscables para Ransack
  def self.ransackable_associations(auth_object = nil)
    ["autor", "categoria"]
  end
  
  # Métodos públicos
  def imagen_portada
    imagenes.first if imagenes.attached?
  end
  
  def productos_relacionados
    Producto.activos
            .where(categoria: categoria)
            .where.not(id: id)
            .where('stock > ?', 0)
            .order('RANDOM()')
  end
  
  def disponible?
    fecha_baja.nil? && stock > 0
  end
  
  def soft_delete!
    update(fecha_baja: Date.current, stock: 0)
  end
  
  def restaurar!
    update(fecha_baja: nil)
  end
  
  private
  
  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end
  
  def set_fecha_modificacion
    self.fecha_modificacion = Time.current
  end
end