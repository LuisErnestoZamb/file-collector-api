namespace :subir_data do
  desc "Submiting files"
  task procesar: :environment do
    q = Recurso.where(procesado: false)
    q.each do |recurso|
      HTTParty.post(
        ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/ingresar",
        :headers => {
          'Content-Type' => 'binary/octet-stream',
          'Accept-Encoding' => 'gzip,deflate,sdch',
          'Accept-Language' => 'en-US,en;q=0.8,pt;q=0.6'
        },
        body: {
          numeroCnp: recurso.cnpnumero,
          file: recurso.archivo
        }
      )
      recurso.procesado = true
      recurso.save
    end
  end
end
