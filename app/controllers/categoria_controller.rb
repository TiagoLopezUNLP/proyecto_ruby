class CategoriaController < ApplicationController
  before_action :set_categorium, only: %i[ show edit update destroy ]

  # GET /categoria or /categoria.json
  def index
    @q = Categorium.ransack(params[:q])
    @categoria = @q.result(distinct: true).order(:nombre).paginate(page: params[:page], per_page: 5)
  end

  # GET /categoria/1 or /categoria/1.json
  def show
  end

  # GET /categoria/new
  def new
    @categorium = Categorium.new
  end

  # GET /categoria/1/edit
  def edit
  end

  # POST /categoria or /categoria.json
  def create
    @categorium = Categorium.new(categorium_params)

    respond_to do |format|
      if @categorium.save
        format.html { redirect_to categoria_path, notice: "Categoría creada exitosamente." }
        format.json { render :show, status: :created, location: @categorium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @categorium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoria/1 or /categoria/1.json
  def update
    respond_to do |format|
      if @categorium.update(categorium_params)
        format.html { redirect_to categoria_path, notice: "Categoría actualizada exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: @categorium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @categorium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria/1 or /categoria/1.json
  def destroy
    # Verificar si tiene productos antes de eliminar
    if @categorium.productos.any?
      redirect_to categoria_path,
                  alert: "No se puede eliminar la categoría '#{@categorium.nombre}' porque tiene #{@categorium.productos.count} producto(s) asociado(s).",
                  status: :see_other
      return
    end

    @categorium.destroy!

    respond_to do |format|
      format.html { redirect_to categoria_path, notice: "Categoría eliminada exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_categorium
    @categorium = Categorium.find_by(id: params[:id])

    unless @categorium
      redirect_to categoria_path,
                  alert: "La categoría no existe o ha sido eliminada.",
                  status: :see_other
      return
    end
  end

    # Only allow a list of trusted parameters through.
    def categorium_params
      params.expect(categorium: [ :nombre ])
    end
end
