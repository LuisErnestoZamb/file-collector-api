namespace :subir_data do
  desc "TODO"
  task procesar: :environment do
    q = Recurso.where(procesado: false)
  end

end
