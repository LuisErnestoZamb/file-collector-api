class RecursosController < ApplicationController
  include ActionController::MimeResponds

  # GET /renderizar.php?id=
  def index
    response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/traer_afiliado_por_id/?afiliado_id="+params[:id].to_s+"&pre_token="+"")
    render html: response.body.html_safe
  end

  # POST /subidaExterna.php?carnet=
  # POST /subidaExterna.php?numeroCnp=
  def subida
    if params[:carnet]
      response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/buscar_mixto/?carnet="+params[:carnet].to_s)
      render json: response.body
    elsif (params[:nac] && params[:cedula])
      response = HTTParty.get(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/buscar_mixto/?identidad="+params[:nac] + params[:cedula])
      render json: response.body
    elsif params[:numeroCnp]
      @recurso = Recurso.new(cnpnumero: params[:numeroCnp], procesado: false, archivo: params[:file])
      if @recurso.save
        puts @recurso
        render json: @recurso, status: :created, location: @recurso
      else
        puts @recurso.errors.to_json
        puts params
        render json: @recurso.errors, status: :unprocessable_entity
      end
    end
  end

end
