IEPsystem::Application.routes.draw do
  resources :taxonomies

  get "sessions/create"

  resources :posts

  resources :attachments

  resources :classrooms

  resources :semesters

  resources :teachers

  resources :roles

  get 'users/login' => 'users#login'
  resources :users

  resources :students 

  get 'students/:id/addc' => 'students#addc'
  post 'students/:id/dealaddc' => 'students#dealaddc'
  post 'classrooms/:id/remove_a_student' => 'classrooms#remove_a_student'
  post 'classrooms/:id/remove_a_teacher' => 'classrooms#remove_a_teacher'
  post 'classrooms/add_students' => 'classrooms#add_students'
  post 'classrooms/add_teachers' => 'classrooms#add_teachers'

  get 'admin' => 'admin#menu'
  get 'admin/menu' => 'admin#menu'
  get 'admin/:id/edit_tinc' => 'admin#edit_tinc'
  get 'admin/:id/edit_sinc' => 'admin#edit_sinc'
  post 'admin/save_tinc' => 'admin#save_tinc'
  post 'admin/save_sinc' => 'admin#save_sinc'
  get 'admin/:seme/print1' => 'admin#print1'
  get 'admin/:seme/print2' => 'admin#print2'
  get 'admin/:seme/print_students' => 'admin#print_students'

  post 'admin/posts/upload' => 'admin/posts#upload'
  get 'admin/posts/download' => 'admin/posts#download'
  namespace :admin do
     resources :posts
  end

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

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
