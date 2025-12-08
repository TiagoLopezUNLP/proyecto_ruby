class Categorium < ApplicationRecord
  has_many :productos , dependent: :restrict_with_error ,foreign_key: 'categoria_id'
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "nombre", "updated_at"]
  end
end
