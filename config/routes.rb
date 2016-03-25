Rails.application.routes.draw do


  get 'puntuaciones/index'

  devise_for :usuarios, :controllers => {
    :sessions => 'usuario/sessions',
    :registrations => 'usuario/registrations',
    :passwords => 'usuario/password'
    }

  post 'registrar' => 'servicio/usuarios#registrar'
  post 'login' => 'servicio/usuarios#login'

  post 'juegos/registrar' => 'servicio/juegos#registrar'
  post 'juegos/comprobar' => 'servicio/juegos#comprobar_nombre'

  post 'puntuaciones/registrar' => 'servicio/puntuaciones#registrar'
  post 'puntuaciones/mejores' => 'servicio/puntuaciones#mejores'

  root 'inicio#inicio'
  
  get 'mis-juegos' => 'juegos#mis_juegos'
  
  get 'juegos' => 'juegos#index'
  get 'buscar' => 'juegos#buscar'
  
  get 'puntuaciones/:juego_id' => 'puntuaciones#index', :as => 'puntuaciones_juego'
  
  get 'puntuaciones/niveles/:puntuacion_id' => 'niveles#index', :as => 'puntuaciones_por_nivel'

  devise_scope :usuario do
   get "mi-cuenta", to: "devise/passwords#edit"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
