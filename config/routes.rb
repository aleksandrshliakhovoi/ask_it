Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#index'

  # get '/questions', to: 'questions#index'
  # get '/questions/new', to: 'questions#new'
  # get '/questions/:id/edit', to: 'questions#edit'
  # post '/questions', to: 'questions#create'

  resource :session, only: %i[new create destroy] # if in single there are no id
  resources :users, only: %i[new edit update create]

  resources :questions do
    get :about, on: :collection
    resources :answers, except: %i[new show]
  end
end
