class RecursosController < ApplicationController
  before_action :set_recurso, only: [:show, :update]

  # GET /recursos
  def index
    @recursos = Recurso.all

    render json: @recursos
  end

  # POST /recursos
  def create
    @recurso = Recurso.new(recurso_params)

    if @recurso.save
      render json: @recurso, status: :created, location: @recurso
    else
      render json: @recurso.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurso
      @recurso = Recurso.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recurso_params
      params.require(:recurso).permit(:cnpnumero, :archivo, :procesado)
    end
end
