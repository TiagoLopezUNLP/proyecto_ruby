class DetalleVentaController < ApplicationController
  before_action :set_detalle_ventum, only: %i[ show edit update destroy ]

  # GET /detalle_venta or /detalle_venta.json
  def index
    @detalle_venta = DetalleVentum.all
  end

  # GET /detalle_venta/1 or /detalle_venta/1.json
  def show
  end

  # GET /detalle_venta/new
  def new
    @detalle_ventum = DetalleVentum.new
  end

  # GET /detalle_venta/1/edit
  def edit
  end

  # POST /detalle_venta or /detalle_venta.json
  def create
    @detalle_ventum = DetalleVentum.new(detalle_ventum_params)

    respond_to do |format|
      if @detalle_ventum.save
        format.html { redirect_to @detalle_ventum, notice: "Detalle ventum was successfully created." }
        format.json { render :show, status: :created, location: @detalle_ventum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detalle_ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalle_venta/1 or /detalle_venta/1.json
  def update
    respond_to do |format|
      if @detalle_ventum.update(detalle_ventum_params)
        format.html { redirect_to @detalle_ventum, notice: "Detalle ventum was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @detalle_ventum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @detalle_ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalle_venta/1 or /detalle_venta/1.json
  def destroy
    @detalle_ventum.destroy!

    respond_to do |format|
      format.html { redirect_to detalle_venta_path, notice: "Detalle ventum was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_ventum
      @detalle_ventum = DetalleVentum.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def detalle_ventum_params
      params.expect(detalle_ventum: [ :venta_id, :producto_id, :cantidad, :precio_unitario, :subtotal ])
    end
end
