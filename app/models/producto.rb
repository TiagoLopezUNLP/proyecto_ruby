class Producto < ApplicationRecord
  enum :tipo, %i[vinilo cd]
  enum :estado, %i[nuevo usado]

  belongs_to :autor
  belongs_to :categoria
  has_many :imagenes, dependent: :destroy
end
