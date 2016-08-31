Rails.application.routes.draw do
    devise_for :users, :controllers => { registrations: 'registrations' }
    get 'welcome/index'
    resources :users

    resources :courses do
      resources :events do
          member do
            get 'approve'
            get 'deny'
          end
      end
      member do
          get 'pending_events_list'
      end
    end

    authenticated :user do
        root 'courses#index', as: "authenticated_root"
    end

    root 'welcome#index'
end
