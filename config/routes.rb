Rails.application.routes.draw do
  get 'pagos/index'
  get 'waiters/index'
  get 'reservations/index'
  get 'reserve', to: 'reserve#index' ,as: 'reserve'
  get 'reserve/branch/:id',  to: 'reserve#branch'
  get 'reserve/:id',  to: 'reserve#show', as:'reserveshow'
  
  get 'user/getUser'
  get 'featured_branch/index'
  post 'featured_branch/featuredbranch'
  root to: "home#index"
  get 'home/privacy_policy'
  get 'instruction/index'
  get 'roles/index'
  post 'roles/assignrole'
  get 'dashboard/index'
  get 'categories/show_products'
  post 'products/assign_category'
  get 'singular_branch/index'
  post 'singular_branch/create'
  get 'reviews/fire_reviews'
  get 'waiter_call' , to: 'waiter_call#index' ,as: 'waiter_call'
  post 'waiter_call/create'
  get 'waiter_state' , to: 'waiter_state#index' ,as: 'waiter_state'
  post 'waiter_state/create'
  get 'admin_cook_accounts/form'
  get 'admin_cook_accounts/show/:id', to: 'admin_cook_accounts#show'
  get 'admin_cook_accounts/delete'

  get 'admin_branch_leader/form'
  get 'admin_branch_leader/show/:id', to: 'admin_branch_leader#show'
  get 'admin_branch_leader/delete'
  post 'admin_branch_leader/create'

  get 'admin_waiter_account/form'
  get 'admin_waiter_account/show/:id', to: 'admin_waiter_account#show',as: 'show'
  post 'admin_waiter_account/create'
  get 'admin_waiter_account/delete'
  get 'admin_waiter_account/deletetable'
  get 'admin_waiter_account/asigntables'
  post 'pagos/payment'
  
  get 'pagos/delete'
  
  get 'charge', to: 'charge#index', as: 'charge'
  post 'charge/pay', as: 'charge_pay'
  get 'charge/return_after_form'
  
  get 'subscription', to: 'subscription#index', as: 'subscription'
  post 'subscription/init', as: 'subscription_init'
  get 'subscription/card_inscription_return', as: 'subscription_card_indscription_return'
  get 'subscription/success/:subscription_id', to: 'subscription#success', as: 'subscription_success'
  
  get '/login', to: 'auth#login'
  
  get 'send_report_email', to: 'reviews#send_report'
  get 'send_mail', to: 'pagos#send_mail', as: :send_mail
  
  get 'tables/branch/:id',  to: 'tables#branch'
  get 'tables/tablebranch/:id', to: 'tables#tablebranch'
  get 'tables/waiterview', to: 'tables#waiterview'
  get 'tables/menu/:id',  to: 'tables#menu'
  get 'reviews/restaurant_reviews'

  get 'pagos/detail/:id',  to: 'pagos#detail'

  get 'admin_branch_leader/leaderbranch/:id', to: 'admin_branch_leader#leaderbranch'
  get 'admin_cook_accounts/cookbranch/:id', to: 'admin_cook_accounts#cookbranch'
  get 'admin_waiter_account/waiterbranch/:id', to: 'admin_waiter_account#waiterbranch'
  resources :tables
  resources :restaurant_categories
  resources :reviews
  resources :products
  resources :categories
  resources :orders
  get 'orders/branch/:id',  to: 'orders#branch'
  get 'orders/history/:id',  to: 'orders#history'
  post 'orders/changestatus/:id',  to: 'orders#changestatus'
  post 'orders/transaction'
  post 'orders/transaction_edit'
  
  resources :branches
  resources :menus
  resources :restaurants
  resources :posts
  resources :post_categories
  devise_for :users, controllers: {
    sessions: 'user/sessions', registrations: 'user/registrations'  #only[:show, :edit, :update]
  }
  resources :waiters
  resources :admin_cook_accounts
  
  ## Admin Routes
  get 'admin/index'
  get 'admin/restaurants'
  get 'admin/branches'
  get 'admin/products'
  get 'admin/categories'
  get 'admin/menus'
  get 'admin/orders'
  get 'admin/reviews'
  get 'admin/instructions' 
  get 'admin/tables'
  get 'admin/waiters'
  get 'admin/leaders'
  get 'admin/cooks'
  
  # Operation Routes
  get 'operations/users'
  get 'operations/orders'
  get 'operations/restaurants'
  get 'operations/featured_branches'
  
end
