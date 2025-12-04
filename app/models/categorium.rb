class Categorium < ApplicationRecord
  has_many :productos
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "nombre", "updated_at"]
  end
end
