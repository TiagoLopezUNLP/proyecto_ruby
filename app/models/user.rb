class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role,
       {
         cliente: "cliente",
         administrador: "administrador",
         gerente: "gerente",
         empleado: "empleado"
       },
       default: "cliente",
       validate: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end

end