class UsuariosController < ApplicationController
  before_action :authenticate_user!

  def index
    @usuarios = User.all
  end

  def show
    @usuario = User.find(params[:id])
  end
end