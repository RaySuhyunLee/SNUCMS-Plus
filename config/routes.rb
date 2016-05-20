Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations"
  }
  
  # nested routing for courses, issues and comments.
  resources :courses do
    resources :issues, only: [:index, :new, :create, :show, :update, :destroy] do
	  resources :comments, only: [:new, :create, :destroy, :index]
      get 'subscribe', on: :member 
		end
    get 'subscribe', on: :member
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Wiki routing
  get 'wiki' => 'wiki_pages#index', as: :wiki
  get 'wiki/:title/new' => 'wiki_pages#new', as: :new_wiki_page
  get 'wiki/:title/empty' => 'wiki_pages#empty', as: :empty_wiki_page
  get 'wiki/:title/edit' => 'wiki_pages#edit', as: :edit_wiki_page
  get 'wiki/:title' => 'wiki_pages#show', as: :wiki_page
  patch 'wiki/:title' => 'wiki_pages#update'
  put 'wiki/:title' => 'wiki_pages#update'
  delete 'wiki/:title' => 'wiki_pages#destroy'

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
