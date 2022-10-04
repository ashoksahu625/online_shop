Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
    	resources :users 
    	resources :cart_items do 
    		collection do
    			get :get_manu_items
    			post :update_cart_items
    		end
    	end	
    end
  end

end
