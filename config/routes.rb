RedBook::red_book
Rails.application.routes.draw do
  namespace :api do
    get '/books' => 'books#index'
    get '/books/:id' => 'books#show'
    post '/books' => 'books#create'
  end
end
