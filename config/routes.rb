Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get   'fix_basic_info'
      get   'position' 
    end
    collection { post :import } 
    collection do
      get 'employees_on_duty'
    end  
   
    resources :attendances, only: [:edit, :update] do
      member do  
        get 'overtime_request'
        patch 'update_overtime'
      end
    end   
    
  end
end 