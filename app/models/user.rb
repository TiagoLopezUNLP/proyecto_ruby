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
end