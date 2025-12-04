class AutorsController < ApplicationController
  before_action :set_autor, only: %i[ show edit update destroy ]

  # GET /autors or /autors.json
  def index
    @autors = Autor.all
  end

  # GET /autors/1 or /autors/1.json
  def show
  end

  # GET /autors/new
  def new
    @autor = Autor.new
  end

  # GET /autors/1/edit
  def edit
  end

  # POST /autors or /autors.json
  def create
    @autor = Autor.new(autor_params)

    respond_to do |format|
      if @autor.save
        format.html { redirect_to autors_path, notice: "Artista creado exitosamente." }
        format.json { render :show, status: :created, location: @autor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @autor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autors/1 or /autors/1.json
  def update
    respond_to do |format|
      if @autor.update(autor_params)
        format.html { redirect_to autors_path, notice: "Artista actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: @autor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @autor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autors/1 or /autors/1.json
  def destroy
    @autor.destroy!

    respond_to do |format|
      format.html { redirect_to autors_path, notice: "Autor was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autor
      @autor = Autor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def autor_params
      params.expect(autor: [ :nombre ])
    end
end
