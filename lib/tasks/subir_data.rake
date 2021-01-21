require 'posix/spawn'
require 'rest_client'
namespace :subir_data do
  desc "Submiting files"
  task procesar: :environment do
    q = Recurso.where(procesado: false)
    q.each do |recurso|
      pid  = POSIX::Spawn::spawn('curl', '-o', recurso.carpeta_file_name, recurso.carpeta.expiring_url(160))
      stat = Process::waitpid(pid)
      RestClient.post(ENV['RUTA_EXTERNA_WHO']+"/subidasexternas/ingresar?numeroCnp=" + recurso.cnpnumero.to_s, :file => File.new(recurso.carpeta_file_name)){ |response, request, result|
        if response.code == 200
          recurso.procesado = true
          recurso.save
        else
          puts "Error code:#{response.code.to_s}. result: #{result.to_s}"
        end
      }
    end
  end
end
