Converse::Application.routes.draw do
  get '/auth/:provider/callback', to: 'session#create'
  get '/auth/failure', to: 'session#failure'
  root "main#index"
end
