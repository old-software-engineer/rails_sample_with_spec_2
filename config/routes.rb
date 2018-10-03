Rails.application.routes.draw do
  
  root to: 'modes#index'
	
  # User Settings
  resources :user_settings

  # Audit Trail
  resources :audit_trail, only: [:index] do
    collection do
      post :search
      get :export_csv
    end
  end

  # Studies
  resources :studies, only: [:index, :destroy, :create] do
    collection do
    	get :new_from_mdr
    	#get :new_from_study
    	get :new_from_define
    end
    member do
      get :history
      #post :build
    end
  end
  
  namespace :studies do
	  resources :bases, only: [:edit, :update] do
      member do
        put :default
        put :terminology_toggle
      end
    end
    resources :forms, except: [:index] do
      member do
        put :move
        get :crf
      end
      collection do
        post :create_local
      end
      resources :normal_groups, only: [] do
        member do
          get :add_bc
        end
      end
    end
    
    resources :variables, only: [:index, :show, :edit] do
      member do
        get :status
        put :toggle
        put :update_comment
        put :remove_comment
        put :update_derivation
        put :remove_derivation
      end
    end
  end

end
