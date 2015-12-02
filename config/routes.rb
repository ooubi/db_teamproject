Rails.application.routes.draw do
  resources :task
  resources :user
  resources :original_data_file
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

# Static pages
root 'static_pages#home'
get 'settings' => 'static_pages#settings'
get 'admin/home' => 'static_pages#admin_home'
get 'admin/settings' => 'static_pages#admin_settings'
# Admin
match 'admin(.?)', :to => 'admin_session#index', :via => :get
get 'admin/login' => 'admin_session#new'
post 'admin/login' => 'admin_session#create'
get 'admin/logout' => 'admin_session#destroy'
get 'admin/edit' => 'user#edit'
post 'admin/update' => 'user#update'
get 'admin/user' => 'user#show'
post 'admin/user' => 'user#show'

# Session
get 'login' => 'session#new'
post 'login' => 'session#create'
get 'secession'  => 'session#destroy'
# User
get 'join' => 'user#new'
post 'join' => 'user#create'
get 'sign-out' => 'user#destroy'
get 'edit' => 'user#edit'
post 'update' => 'user#update'

# Task
get 'task/' => 'task#index'
get 'admin/task/' => 'task#show'
get 'task/new' => 'task#new'
post 'task/new' => 'task#create'

# Original data type
get 'original_data_type/new' => 'original_data_type#new'
post 'original_data_type/new' => 'original_data_type#create'
get 'original_data_type/show' => 'original_data_type#show'
get 'original_data_type/index' => 'original_data_type#index'
get 'original_data_type/destroy' => 'original_data_type#destroy'

# Participate
get 'participate/index' => 'participate#index'
get 'participate/show' => 'participate#show'
get 'participate/new' => 'participate#new'
get 'participate/create' => 'participate#create'
get 'participate/update' => 'participate#update'

# Original Data File
post 'original_data_file/upload' => 'original_data_file#upload'
post 'original_data_file/:id' => 'original_data_file#show_file'

end
