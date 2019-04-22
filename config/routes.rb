RedBook::red_book
Rails.application.routes.draw do
  namespace :api do
    get '/books' => 'books#index'
    post '/books' => 'books#create'
  end
end
