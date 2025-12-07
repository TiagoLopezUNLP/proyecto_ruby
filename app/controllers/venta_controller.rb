class VentaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ventum, only: %i[ show edit update destroy factura ]

  # GET /venta or /venta.json
  def index
    @venta = Ventum.activas.order(created_at: :desc)
  end

  # GET /venta/1 or /venta/1.json
  def show
  end

  # GET /venta/nueva (Paso 1: Seleccionar productos)
  def nueva
    # Inicializar carrito en sesión si no existe
    session[:carrito] ||= []
    
    # Buscar productos disponibles
    @q = Producto.activos.where("stock > 0").ransack(params[:q])
    @productos = @q.result(distinct: true).paginate(page: params[:page], per_page: 12)
    
    # Obtener productos del carrito
    @carrito_productos = Producto.where(id: session[:carrito].map { |item| item['producto_id'] })
  end

  # POST /venta/agregar_producto
  def agregar_producto
    session[:carrito] ||= []
    producto_id = params[:producto_id].to_i
    cantidad = params[:cantidad].to_i
    
    producto = Producto.find(producto_id)
    
    # Verificar stock
    if cantidad > producto.stock
      redirect_to nueva_venta_path, alert: "Stock insuficiente para #{producto.nombre}"
      return
    end
    
    # Buscar si ya existe en el carrito
    item_existente = session[:carrito].find { |item| item['producto_id'] == producto_id }
    
    if item_existente
      # Actualizar cantidad
      nueva_cantidad = item_existente['cantidad'] + cantidad
      if nueva_cantidad > producto.stock
        redirect_to nueva_venta_path, alert: "Stock insuficiente para #{producto.nombre}"
        return
      end
      item_existente['cantidad'] = nueva_cantidad
    else
      # Agregar nuevo item
      session[:carrito] << {
        'producto_id' => producto_id,
        'cantidad' => cantidad,
        'precio' => producto.precio
      }
    end
    
    redirect_to nueva_venta_path, notice: "#{producto.nombre} agregado al carrito"
  end

  # DELETE /venta/quitar_producto/:producto_id
  def quitar_producto
    session[:carrito]&.reject! { |item| item['producto_id'] == params[:producto_id].to_i }
    redirect_to nueva_venta_path, notice: "Producto eliminado del carrito"
  end

  # GET /venta/datos_comprador (Paso 2: Datos del comprador)
  def datos_comprador
    if session[:carrito].blank?
      redirect_to nueva_venta_index_path, alert: "Debe agregar productos al carrito primero"
      return
    end
    
    @ventum = Ventum.new
    @carrito_productos = Producto.where(id: session[:carrito].map { |item| item['producto_id'] })
    @total = calcular_total
  end

  # POST /venta/finalizar
  def finalizar
    if session[:carrito].blank?
      redirect_to nueva_venta_path, alert: "El carrito está vacío"
      return
    end
    
    @ventum = Ventum.new(ventum_params)
    @ventum.user_id = current_user.id
    @ventum.total = calcular_total
    @ventum.fecha = Time.current
    
    # Cargar variables necesarias para la vista en caso de error
    @carrito_productos = Producto.where(id: session[:carrito].map { |item| item['producto_id'] })
    @total = calcular_total
    
    ActiveRecord::Base.transaction do
      if @ventum.save
        # Crear detalles de venta y actualizar stock
        session[:carrito].each do |item|
          producto = Producto.find(item['producto_id'])
          
          DetalleVentum.create!(
            venta_id: @ventum.id,
            producto_id: producto.id,
            cantidad: item['cantidad'],
            precio_unitario: item['precio']
          )
          
          # Actualizar stock
          producto.update!(stock: producto.stock - item['cantidad'])
        end
        
        # Limpiar carrito
        session[:carrito] = []
        
        redirect_to @ventum, notice: "Venta registrada exitosamente"
      else
        # Si la validación falla, renderizar la vista con los errores
        render :datos_comprador, status: :unprocessable_entity
      end
    end
    rescue ActiveRecord::RecordInvalid => e
      # Capturar errores de validación en los detalles de venta
      @ventum.errors.add(:base, "Error al crear detalles de venta: #{e.message}")
      render :datos_comprador, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      # Producto no encontrado
      flash.now[:alert] = "Producto no encontrado: #{e.message}"
      render :datos_comprador, status: :unprocessable_entity
    rescue => e
      # Cualquier otro error
      @ventum.errors.add(:base, "Error al procesar la venta: #{e.message}")
      render :datos_comprador, status: :unprocessable_entity
  end

  # GET /venta/1/edit
  def edit
  end

  # PATCH/PUT /venta/1 or /venta/1.json
  def update
    respond_to do |format|
      if @ventum.update(ventum_params)
        format.html { redirect_to @ventum, notice: "Venta actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @ventum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venta/1 or /venta/1.json
  def destroy
    if @ventum.cancelar!
      respond_to do |format|
        format.html { redirect_to venta_path, status: :see_other, notice: "Venta cancelada exitosamente. Stock restaurado." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to venta_path, status: :see_other, alert: "No se pudo cancelar la venta. Ya está cancelada." }
        format.json { render json: { error: "Venta ya cancelada" }, status: :unprocessable_entity }
      end
    end
  end


  def factura

    respond_to do |format|
      format.pdf do
        pdf = FacturaPdf.new(@ventum)
        send_data pdf.render,
                  filename: "factura_#{@ventum.id.to_s.rjust(6, '0')}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline' # 'attachment' para descargar, el inline para ver en el navegador
      end
    end
  end



  private
  def set_ventum
    @ventum = Ventum.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to venta_path, alert: "Venta no encontrada" }
        format.pdf do
          redirect_to venta_path,
                      alert: "La venta con ID #{params[:id]} no fue encontrada."
        end
      end
      return false
  end

    def ventum_params
      params.require(:ventum).permit(:NyA_comprador, :dni_comprador)
    end

    def calcular_total
      total = 0
      session[:carrito].each do |item|
        total += item['precio'].to_f * item['cantidad']
      end
      total
    end
end