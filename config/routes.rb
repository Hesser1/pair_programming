Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  #this part allows to use /api/v1/movies or /api/v2/movies
  # to get shorten or extended versions of JSON detail list with movies in the app
  namespace :api, :via => [:get], :defaults => { :format => :json } do
    namespace :v1 do
      resource 'movies'
    end
    namespace :v2 do
      resource 'movies'
    end
  end
  resources :movies, only: [:index, :show] do
    resources :comments
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
