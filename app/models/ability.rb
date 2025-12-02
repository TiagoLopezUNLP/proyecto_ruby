# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #invitado o usuario sin rol asignado
    user ||= User.new(role: "cliente")

    #el administrador puede usar todas las funcionalesdades
    if user.administrador?
      can :manage, :all
    #el gerente puede gestionar productos, ventas y usuarios no administradores
    elsif user.gerente?
      can :manage, [Producto, User]

      #restricciones para el gerente sobre usuarios administradores
      cannot :create, User, role: "administrador"
      cannot :update, User, role: "administrador"
      cannot :destroy, User, role: "administrador"

    #el empleado puede gestionar productos y ventas y leer usuarios
    elsif user.empleado?
      can :manage, [Producto]
      can :read, User
    #el cliente puede ver productos y sus propias ventas
    else #cliente
      can :read, user_id: user.id
    end

  end
end
