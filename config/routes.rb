Rails.application.routes.draw do
  get 'profile/index'

  devise_for :users, controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations"
  }

  devise_scope :user do 
    get 'welcome', to: "accounts/registrations#success", as: :welcome
  end


  # nested routing for courses, issues and comments.
  resources :courses do
    resources :issues, only: [:index, :new, :create, :show, :update, :destroy] do
      resources :comments, only: [:create, :destroy] do
        get 'get_contents' => 'comments#get_contents', on: :member
        post 'update_contents' => 'comments#update_contents', on: :member
      end
      post 'update_title' => 'issues#update_title', on: :member
      post 'update_due' => 'issues#update_due', on: :member
      get 'subscribe', on: :member
    end
    get 'subscribe', on: :member
    patch 'description' => 'courses#update_description', on: :member, as: :update_description
    resources :crawl_logs, only: [:create, :update, :destroy]

  end

  get 'subscribing/courses' => 'courses#subscribing_courses', as: "subscribing_courses"

  # routing for course issues which are filtered with label.
  get 'courses/:course_id/labels/:label' => 'issues#index_labels'

  # routing for calendar.
  get 'calendar' => 'calendar#show'

  # routing for user profile
  get 'profile' => 'profile#index'
  post 'profile/update_desc' => 'profile#update_desc'

  # routing for user issues
  get 'profile/issues' => 'issues#index', as: :profile_issues
  post 'profile/issues' => 'issues#create', as: :user_issues
  get 'profile/issues/new' => 'issues#new', as: :new_profile_issue
  get 'profile/issues/:id' => 'issues#show', as: :profile_issue
  patch 'profile/issues/:id' => 'issues#update'
  put 'profile/issues/:id' => 'issues#update'
  delete 'profile/issues/:id' => 'issues#destroy'
  post 'profile/issues/:id/update_title' => 'issues#update_title'
  post 'profile/issues/:id/update_due' => 'issues#update_due'
  get 'profile/issues/:id/subscribe' => 'issues#subscribe', as: :subscribe_profile_issue
  get 'profile/issues/:issue_id/comments/:id/get_contents' => 'comments#get_contents'
  post 'profile/issues/:issue_id/comments/:id/update_contents' => 'comments#update_contents'
  post 'profile/issues/:issue_id/comments' => 'comments#create', as: :profile_issue_comments
  delete 'profile/issues/:issue_id/comments/:id' => 'comments#destroy', as: :profile_issue_comment
  get 'profile/labels/:label' => 'issues#index_labels'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Home routing
  get 'home/load_recent_timeline'
  get 'profile/load_subscription_timeline'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Wiki routing
  get 'wiki' => 'wiki_pages#index', as: :wiki
  post 'wikipage/render' => 'wiki_pages#render_page'
  post 'wikipage/permission' => 'wiki_pages#edit_permission'
  get 'wiki/:title/new' => 'wiki_pages#new', as: :new_wiki_page
  get 'wiki/:title/empty' => 'wiki_pages#empty', as: :empty_wiki_page
  get 'wiki/:title/edit' => 'wiki_pages#edit', as: :edit_wiki_page
  get 'wiki/:title/history' => 'wiki_pages#history', as: :history_wiki_page
  get 'wiki/:title/revert' => 'wiki_pages#revert_page', as: :revert_wiki_page
  get 'wiki/:title' => 'wiki_pages#show', as: :wiki_page
  patch 'wiki/:title' => 'wiki_pages#update'
  put 'wiki/:title' => 'wiki_pages#update'
  delete 'wiki/:title' => 'wiki_pages#destroy'

  # Professor routing
  get 'professors/find', as: :find_professor

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
