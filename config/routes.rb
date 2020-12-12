Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match "/subidaExterna.php" => 'recursos#create', via: [:get, :post]
  match "/renderizar.php" => 'recursos#index', via: [:get, :post]
  root :to => redirect(ENV['ruta_principal'])
  get '*path', to: redirect(ENV['ruta_principal'])
end
