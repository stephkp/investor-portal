Rails.application.routes.draw do  
  root 'pages#index'
  
  # Health check endpoint
  get 'up', to: 'rails/health#show'

  # GraphQL endpoint
  post '/graphql', to: 'graphql#execute'

  # GraphiQL IDE (for development)
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  resources :investors, only: [:index, :new, :create, :show, :edit, :update] do
    get 'success', on: :collection
    member do
      get 'download/:document_id', to: 'investors#download', as: 'download'
    end
  end

end