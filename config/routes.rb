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
      get 'pendingEvents', to: 'events#pending_events', as: 'pending_events'
      get 'pendingEvents/:id', to: 'events#pending_event', as: 'pending_event'
    end

    authenticated :user do
        root 'courses#index', as: "authenticated_root"
    end

    root 'welcome#index'
end
