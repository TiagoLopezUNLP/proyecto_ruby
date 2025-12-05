class ProductosController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource except: [:show]
  before_action :set_producto, only: %i[ show edit update destroy delete_image ]

  

  # GET /productos or /productos.json
  def index
    #utilizo ransack para busqueda y filtros
    @q = Producto.activos.ransack(params[:q])
    #utilizo will_paginate para paginacion
    @productos = @q.result(distinct: true).paginate(page: params[:page], per_page: 15)
  end

  # GET /productos/1 or /productos/1.json
  # Accesible públicamente para el storefront
  def show
    @productos_relacionados = @producto.productos_relacionados.limit(4)
    # Si el usuario no está autenticado, renderiza la vista del storefront
    if !user_signed_in?
      render 'home/show'
    end
    # Si está autenticado, renderiza la vista administrativa normal
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
  end

  # POST /productos or /productos.json
  def create
    @producto = Producto.new(producto_params)

    # creo un nuevo autor si se ingresó uno en el campo de texto
    if params[:producto][:nuevo_autor].present?
      autor = Autor.find_or_create_by(nombre: params[:producto][:nuevo_autor])
      @producto.autor = autor
    end

    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: "Producto Creado." }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1 or /productos/1.json
  def update
  # creo un nuevo autor si se ingresó uno en el campo de texto
  if params[:producto][:nuevo_autor].present?
    autor = Autor.find_or_create_by(nombre: params[:producto][:nuevo_autor])
    @producto.autor = autor
  end

  # Separar las imágenes
  update_params = producto_params
  nuevas_imagenes = update_params.delete(:imagenes)

  respond_to do |format|
    if @producto.update(update_params)
      # Agregar nuevas imágenes por separado para no perder las actuales
      if nuevas_imagenes.present?
        imagenes_validas = nuevas_imagenes.reject(&:blank?)
        @producto.imagenes.attach(imagenes_validas) if imagenes_validas.any?
      end
      
      format.html { redirect_to productos_path, notice: "Producto actualizado.", status: :see_other }
      format.json { render :show, status: :ok, location: @producto }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @producto.errors, status: :unprocessable_entity }
    end
  end
end

  # DELETE /productos/1 or /productos/1.json
  def destroy
    #hago un borrado logico
    @producto.update(
      fecha_baja: Time.current,
      stock: 0,
    )


    respond_to do |format|
      format.html { redirect_to productos_path, notice: "Producto Eliminado.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def delete_image
    imagen = @producto.imagenes.find(params[:imagen_id])
    imagen.purge
    redirect_to edit_producto_path(@producto), notice: "Imagen eliminada correctamente."
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])

      rescue ActiveRecord::RecordNotFound
        respond_to do |format|
          format.html { redirect_to productos_path, alert: "Producto no encontrado" }
        end
        return false
    end

    # Only allow a list of trusted parameters through.
    def producto_params
      params.require(:producto).permit(
        :nombre,
        :descripcion,
        :precio,
        :stock,
        :fecha_ingreso,
        :fecha_modificacion,
        :fecha_baja,
        :tipo,
        :estado,
        :autor_id,
        :categoria_id,
        :audio_muestra,
        imagenes: [] 
      )
    end
  end