LicenseManagement::Application.routes.draw do

  resources :users do
    collection do
      get :forgot_password,:change_password,:dashboard,:delete_user,:refersh_user
    end
  end

  resources :product_licenses do
    collection do
      get :generate_keys, :regeneration_report, :unassigned_report, :deleted_report,:show_licenses ,:date_range_license_report,:regeneration_report_html,

          :license_report,:unassigned_report_html,:deleted_key_report_html,:delete_keys, :currently_generated_licenses

      post :generate_license_key,:product_license_report,:product_license_report_html,:manual_license_generate,:create_manual_license
    end
  end


  resources :products do
    collection do 

      get :reset_requests,:search_email,:allow_regeneration,:delete_product

    end
  end 
  
  resources :sessions do 
    collection do
      get :recovery,:change_password
    end
  end

  root :to => 'sessions#new'
  
 

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
