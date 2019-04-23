# RedBook::red_book
Rails.application.routes.draw do
  namespace :api do
    get '/books' => 'books#index'
    get '/books/:id' => 'books#show'
    post '/books' => 'books#create'
    patch '/books/:id' => 'books#update'

    get '/reviews' => 'reviews#index'
    post '/reviews' => 'reviews#create'

    post '/users' => 'users#create'
    post '/sessions' => 'sessions#create'
  end
end
