class ImagensController < ApplicationController
  before_action :set_imagen, only: %i[ show edit update destroy ]

  # GET /imagens or /imagens.json
  def index
    @imagens = Imagen.all
  end

  # GET /imagens/1 or /imagens/1.json
  def show
  end

  # GET /imagens/new
  def new
    @imagen = Imagen.new
  end

  # GET /imagens/1/edit
  def edit
  end

  # POST /imagens or /imagens.json
  def create
    @imagen = Imagen.new(imagen_params)

    respond_to do |format|
      if @imagen.save
        format.html { redirect_to @imagen, notice: "Imagen was successfully created." }
        format.json { render :show, status: :created, location: @imagen }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @imagen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imagens/1 or /imagens/1.json
  def update
    respond_to do |format|
      if @imagen.update(imagen_params)
        format.html { redirect_to @imagen, notice: "Imagen was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @imagen }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @imagen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imagens/1 or /imagens/1.json
  def destroy
    @imagen.destroy!

    respond_to do |format|
      format.html { redirect_to imagens_path, notice: "Imagen was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imagen
      @imagen = Imagen.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def imagen_params
      params.expect(imagen: [ :url, :producto_id ])
    end
end
