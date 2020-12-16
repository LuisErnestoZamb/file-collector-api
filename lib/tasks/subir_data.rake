namespace :subir_data do
  desc "Submiting files"
  task procesar: :environment do
    q = Recurso.where(procesado: false)
    q.each do |recurso|
      external_file = recurso.carpeta.expiring_url(60)
      content = open(external_file, "r") { |f| f.read }
      receivedPath = "tmp/"
      large_temp_file = receivedPath + "plain_" + recurso.carpeta_file_name
      Dir.mkdir(receivedPath) unless File.exists?(receivedPath)
      File.write large_temp_file, content
      HTTParty.post(
        ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/ingresar",
        multipart: true,
        :headers => {
          'Content-Type' => 'binary/octet-stream',
          'Accept-Encoding' => 'gzip,deflate,sdch',
          'Accept-Language' => 'en-US,en;q=0.8,pt;q=0.6'
        },
        body: {
          numeroCnp: recurso.cnpnumero,
          file: File.open(large_temp_file)
        }
      )
      recurso.procesado = true
      recurso.save
    end
  end
end
