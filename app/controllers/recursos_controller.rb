class RecursosController < ApplicationController
  include ActionController::MimeResponds
  before_action :set_recurso, only: [:show, :update]

  # GET /renderizar.php?id=
  def index
    response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/traer_afiliado_por_id/?afiliado_id="+params[:id].to_s+"&pre_token="+"")
    render html: response.body.html_safe
  end

  # POST /subidaExterna.php?carnet=
  # POST /subidaExterna.php?numeroCnp=
  def create
    if params[:carnet]
      response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/buscar_mixto/?carnet="+params[:carnet].to_s)
      render json: response.body
    elsif (params[:nac] && params[:cedula])
      response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/buscar_mixto/?identidad="+params[:nac] + params[:cedula])
      render json: response.body
    elsif params[:numeroCnp]
      @recurso = Recurso.new
      @recurso.cnpnumero = params[:numeroCnp]
      @recurso.procesado = false
      params[:file].content_type = "image/jpeg"
      @recurso.archivo = params[:file]
      if @recurso.save
        render json: @recurso, status: :created, location: @recurso
      else
        render json: @recurso.errors, status: :unprocessable_entity
      end
    end
  end

end
