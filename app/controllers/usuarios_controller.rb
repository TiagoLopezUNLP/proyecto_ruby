class UsuariosController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: 'User'
  before_action :set_usuario, only: %i[ show edit update destroy ]

  def index
    # Solo administradores y gerentes pueden ver el listado completo
    authorize! :index, User
    @q = User.where.not(id: current_user.id).ransack(params[:q])
    @usuarios = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @usuario = User.new
  end

  def edit
  end

  def create
    @usuario = User.new(usuario_params)

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuarios_path, notice: "Usuario creado exitosamente." }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # Si no se proporciona password, lo removemos de los parámetros
    params_to_update = usuario_params
    if params_to_update[:password].blank?
      params_to_update.delete(:password)
      params_to_update.delete(:password_confirmation)
    end

    respond_to do |format|
      if @usuario.update(params_to_update)
        format.html { redirect_to usuarios_path, notice: "Usuario actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @usuario.destroy!

    respond_to do |format|
      format.html { redirect_to usuarios_path, notice: "Usuario eliminado.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_usuario
      @usuario = User.find(params[:id])
    end

    def usuario_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end