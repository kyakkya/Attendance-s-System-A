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
      get  'attendances/month_checker'
      get  'comfirmation'
      patch 'attendances/update_total_month'
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
      collection do
        get 'overtime_request_info'
        patch 'update_overtime_request_info'
      end
      collection do
        get 'month_request'
        patch 'update_month_request'
      end  
      collection do
        get 'total_month_request'
        patch 'update_total_month_request'
      end  
     
      collection do
        get 'log_page'
        patch 'update_log_page'
      end
    end   
  end
end 