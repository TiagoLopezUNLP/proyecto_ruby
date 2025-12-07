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
      can :manage, [Producto, Ventum, DetalleVentum, Autor, Categorium]
      can :manage, User
      can :index, User  # Puede ver el listado de usuarios

      #restricciones para el gerente sobre usuarios administradores
      cannot :create, User, role: "administrador"
      cannot :update, User, role: "administrador"
      cannot :destroy, User, role: "administrador"
      
      # Puede ver su propio perfil y editarlo (excepto el rol)
      can :update, User, id: user.id
      cannot :update, User, id: user.id, role: user.role

    #el empleado puede gestionar productos y ventas pero NO usuarios
    elsif user.empleado?
      can :manage, [Producto, Ventum, DetalleVentum, Autor, Categorium]
      
      # Solo puede ver y editar su propio perfil (excepto el rol)
      can [:read, :update], User, id: user.id
      cannot :update, User, id: user.id, role: user.role
      cannot :index, User  # NO puede ver el listado de usuarios
      
    #el cliente puede ver productos y sus propias ventas
    else #cliente
      can [:read, :update], User, id: user.id
      cannot :update, User, id: user.id, role: user.role
      can :read, Producto
      can :read, Ventum, user_id: user.id
    end

  end
end
