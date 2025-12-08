class Autor < ApplicationRecord
  has_many :productos , dependent: :nullify
  validates :nombre, presence: true, uniqueness: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "nombre", "updated_at"]
  end
end
